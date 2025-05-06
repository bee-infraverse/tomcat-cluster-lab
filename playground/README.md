# Start indvidual playground

```shell
labctl playground create --help
labctl playground manifest k8s-omni >k8s-omni.yaml
labctl playground create --base k8s-omni --file ./play-k8s-tomcatrepl.yaml k8s-tomcatrepl
```

## Jax demo

### Bootstrap iximiuz

```shell
labctl playground create --base k8s-omni --file ./play-k8s.yaml k8s-tomcatrepl
labctl playground list
PLAYGROUND ID             NAME                     CREATED       STATUS                                 LINK
6819c9304a0a595b263bc8a7  k8s-tomcatrepl-2061771c  1 minute ago  running (expires in 7 hours from now)  https://labs.iximiuz.com/playgrounds/k8s-tomcatrepl-2061771c/6819c9304a0a595b263bc8a7


# id 6814d8e020aab63faee9c2d8
labctl ssh 6819c9304a0a595b263bc8a7
docker version
k get nodes

git clone https://github.com/bee-infraverse/tomcat-cluster-lab
```

- open vscode setup pluginx
  - marp-team.marp-vscode
  - ms-kubernetes-tools.vscode-kubernetes-tools
  - mermaidchart.vscode-mermaid-chart
  - bierner.markdown-mermaid

### Simple Container Adaption

```shell
# Add Tomcat to Containers
cd ~/tomcat-cluster-lab/exmaples/traefik
docker compose build
docker compose up -d

cd ~/tomcat-cluster-lab/exmaples/traefik
curl http://$(docker compose port tomcat 8080)/health
curl -iL http://$(docker compose port tomcat 8080)/
# review jmx http api - jolokia (Roland Huss)
curl -sL --user jolokia:jolokia \
  http://$(docker compose port tomcat 8080)/jolokia | jq .

# check accesslog only files are supported!
docker compose exec tomcat \
  /bin/sh -c "cat /usr/local/tomcat/logs/localhost_access_log.*"
docker compose exec tomcat \
  /bin/sh -c "ls /usr/local/tomcat/logs/"
```

Scale with Traefik

```shell
docker compose --profile traefik up -d
curl -iL -c cookies.txt -v \
  -H "Host: tomcat.local" \
  http://$(docker compose port traefik 80)
# access with same cookie
curl -iL -b cookies.txt -v \
 -H "Host: tomcat.local" \
 http://$(docker compose port traefik 80)


docker compose up --scale tomcat=2 -d
# check existence on your traefik
curl -s  http://$(docker compose port traefik 8080)/api/http/services | \
 jq '.[] | select(.name == "tomcat@docker") | .loadBalancer.servers'

docker stop traefik-tomcat-1

# reuse and replace if new cookie set!
curl -iL -c cookies.txt -b cookies.txt -v \
  -H "Host: tomcat.local" \
  http://$(docker compose port traefik 80)
docker start traefik-tomcat-1

# check all avaliable
docker compose ps
```

Review:

- use standard official docker hub tomcat image
- Review server.xml
- Setup Sticky session (New cookie)
- Stdout logging
- Setenv parameter jvmRoute
- Add WARS (Jolokia) (Multistage)
- Remove default webapps

Options:

- Option Memory 8 resepec Cgroupd >JDK8)
- Hints Kubernetes Resource Resize (Startup)

Todo:

- download war from jar artifact management system!

### Tomcat Session Replication Basics

Example show simple Tomcat HA Cluster replication feature!

```shell
cd ~/tomcat-cluster-lab/examples/clustertest
# build
docker compose build
cat docker-compose.yml 
docker compose up -d
docker compose ps

# scale tomcat repication cluster
docker compose up --scale tomcat=2 -d
docker compose logs --index=2 tomcat
docker compose exec --index=1 tomcat /bin/bash
ps -ef
exit

docker restart clustertest-tomcat-1
curl -iL http://$(docker compose port --index=1 tomcat 8080)/clustertest
curl -iL --user jolokia:jolokia http://$(docker compose port --index=1 tomcat 8080)/jolokia
curl -iL --user jolokia:jolokia http://$(docker compose port --index=1 tomcat 8080)/jolokia/read/java.lang:type=Runtime/Name
```

Review:

- Review Dockerfile
- Review set WAR Share with Volumes at init container that copy!
  - Also possible to copy WAR directly to volume or share a directory!
- Open Retro Application
  - Show Session results
  - Set hello world value
  - start a new tomcat
  - show tomcat first tomcat
  - see state takeover

### Observability

Add monitoring 
```shell
cd ~/tomcat-cluster-lab/examples/httpd2tomcat
docker compose --profile observability build
docker build -t bee42/hello-war:0.1.0
docker export $(docker create --name hello bee42/hello-war:0.1.0) -o target/hello.tar
docker rm hello

docker compose up -d
docker compose --profile observability up -d
curl $(docker compose port httpd 80)/hello
curl --user jolokia:jolokia $(docker compose port httpd 80)/jolokia
# access observability
docker compose exec httpd curl -s "127.0.0.1:9114/jk-watch?mime=xml"
docker compose exec httpd curl -s "127.0.0.1:9118/server-status?auto"
docker compose exec httpd curl -s "tomcat:8004/metrics"
```

- Review server.xml to start connectors
  - also start cluster
  - but currently no loadbalancer setup
- Review mod_jk exporter
- mod_jk
- Java Agent setup
  - jmx-agent
  - otel agent
- Explore Observability
- Missing Log Handler:) (Loki,EFK,ELK Stack)

### Kubernetes scale tomcat 

```shell
cd ~/tomcat-cluster-lab/exmaples/k8s-tomcat-cluster
k create namespace tomcat
k ns tomcat
k apply -k .
k get pods -o wide -l app=tomcat -w

# check jvmRoute
k exec -it tomcat-0 -c tomcat -- env | grep CATALINA_OPTS
k exec -it tomcat-1 -c tomcat -- env | grep CATALINA_OPTS

# check RBAC auth
kubectl auth can-i get pods --as=system:serviceaccount:tomcat:tomcat
kubectl auth can-i get list --as=system:serviceaccount:tomcat:tomcat
k exec -it tomcat-0 -c tomcat -- /bin/bash
APISERVER=https://kubernetes.default.svc.cluster.local
TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
curl -s $APISERVER/api/v1/namespaces/tomcat/pods  \
  --header "Authorization: Bearer $TOKEN" \
  --cacert /run/secrets/kubernetes.io/serviceaccount/ca.crt | more
INGRESS_IP=$(k get node k3d-tomcat-server-0 -o jsonpath="{.status.addresses[0].address}")
COOKIE="Cookie: $(curl -k -i -s --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/ |grep set-cookie  | awk 'BEGIN { FS="[ ]" } ; { print $2 }' |tr -d "\n")"

# Create Session
curl -v -k -H "${COOKIE}" --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/
# Modify session
curl -v -k -H "${COOKIE}" --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/\?name\=hello
# Review
curl -v -k -H "${COOKIE}" --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/

# Cookie, Date
k logs tomcat-1 -c tomcat
```

- Review kubernetes manifest
- Source of bee42-tomcat-valves
- Stateful
- Crazy app as config


## More

### Optimize the playground

- Prepare images and pre load images
  - base images

### Image Volume demo

- https://kubernetes.io/docs/tasks/configure-pod-container/image-volumes/
- https://kubernetes.io/docs/concepts/storage/volumes/#image
- https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#alwayspullimages

```shell
cat >kubeadm-config.yaml<<EOF
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: v1.33.0
networking:
  podSubnet: "10.244.0.0/16"
apiServer:
  extraArgs:
    feature-gates: "ImageVolume=true"
controllerManager:
  extraArgs:
    feature-gates: "ImageVolume=true"
scheduler:
  extraArgs:
    feature-gates: "ImageVolume=true"
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
featureGates:
  ImageVolume: true
EOF
kubeadm init --config=kubeadm-config.yaml
```

check 

```
kubectl -n kube-system get pod kube-apiserver-cplane-01 -o jsonpath="{.spec.containers[0].command}" |jq -r 'map(select(.|startswith("--feature-gates")))'
[
  "--feature-gates=ImageVolume=true"
]
ssh cplane-01
sudo -i
cat /var/lib/kubelet/config.yaml | grep ImageVolume
ImageVolume: true
```

Tomcat repl example

```shell
labctl playground list
labctl cp examples/httpd2tomcat/target/ROOT.war 6814d8e020aab63faee9c2d8:~/ROOT.war
labctl ssh 6814d8e020aab63faee9c2d8
cat >Dockerfile <<EOF
FROM alpine:3.21 AS extract
COPY ROOT.war /ROOT.war
RUN unzip ROOT.war -d /hello

FROM scratch 
COPY --from=extract /hello /hello
EOF

cat >Dockerfile <<EOF
FROM scratch 
COPY ROOT.war /hello.war
EOF
docker build -t registry.iximiuz.com/hello .
docker push registry.iximiuz.com/hello
```

ToDo: Test META-INF/context.xml

- https://tomcat.apache.org/tomcat-11.0-doc/config/context.html

```xml
<Context docBase="/usr/local/tomcat/webapps/hello" reloadable="true">
  <WatchedResource>WEB-INF/web.xml</WatchedResource>
  <WatchedResource>WEB-INF/tld/*.tld</WatchedResource>
  <WatchedResource>WEB-INF/lib/*.jar</WatchedResource>
  <WatchedResource>WEB-INF/classes</WatchedResource>
```

```shell
cat >tomcat-deploy.yaml <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tomcat11-deployment
  labels:
    app: tomcat11
spec:
  replicas: 1
  selector:
    matchLabels:
      app: tomcat11
  template:
    metadata:
      labels:
        app: tomcat11
    spec:
      containers:
        - name: tomcat11
          image: tomcat:11-jdk17
          ports:
            - containerPort: 8080
          volumeMounts:
            - name: webapps-volume
              mountPath: /usr/local/tomcat/webapps/hello
              subPath: hello
      volumes:
        - name: webapps-volume
          image:
            reference: registry.iximiuz.com/hello
            pullPolicy: Always
EOF
```


## Presentation

- https://github.com/zjffun/reveal.js-mermaid-plugin

Options	

- [marp project](https://github.com/marp-team/marp)
  - [marp website](https://marp.app)
- [presenterm] https://github.com/mfontanini/presenterm
- [reveal.js](https://revealjs.com/)
- [iA Presenter](https://ia.net/presenter)
- [obsidian](https://obsidian.md)
- [slidev](https://github.com/slidevjs/slidev)

- https://maeda.pm/2023/09/27/vscode-and-marp-and-mermaid/


marp

- Two Columns: https://stackoverflow.com/questions/69692460/how-to-create-full-slide-size-stretched-three-columns-in-marp-marpit

```shell
marp --html --bespoke.progress --allow-local-files --pdf -o JAX2025-PeterRossbach.pdf -- slides.md 
```

vscode plugins:

```shell
code --install-extension marp-team.marp-vscode
code --install-extension bierner.markdown-mermaid
```

iximiuz tips:

A standalone playground can be a good option, actually. With custom playgrounds you can:

- Create "rich" markdown description [openbao-vault](https://labs.iximiuz.com/playgrounds/openbao-vault-b46f1fb6)
- Embed the slides as a (running) playground tab [istio-101](https://labs.iximiuz.com/playgrounds/istio-101-0c2397b4 - it embeds some internally running web app, but it could be your tiny little server serving the slides)
