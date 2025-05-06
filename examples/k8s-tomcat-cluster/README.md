# Tomcat Replication Cluster Kubernetes

```bash
# deploy
k create namespace tomcat
k ns tomcat
k apply -k .

# check jvmRoute
k exec -it tomcat-0 -c tomcat -- env | grep CATALINA_OPTS
CATALINA_OPTS=-DjvmRoute=tomcat-0
k exec -it tomcat-1 -c tomcat -- env | grep CATALINA_OPTS
CATALINA_OPTS=-DjvmRoute=tomcat-1

# check RBAC auth
kubectl auth can-i get pods --as=system:serviceaccount:tomcat:tomcat
yes
kubectl auth can-i get list --as=system:serviceaccount:tomcat:tomcat
yes

k exec -it tomcat-0 -c tomcat -- /bin/bash
APISERVER=https://kubernetes.default.svc.cluster.local
TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
curl -s $APISERVER/api/v1/namespaces/tomcat/pods  \
  --header "Authorization: Bearer $TOKEN" \
  --cacert /run/secrets/kubernetes.io/serviceaccount/ca.crt | more

k get pods -o wide -l app=tomcat
NAME       READY   STATUS    RESTARTS   AGE   IP           NODE                  NOMINATED NODE   READINESS GATES
tomcat-1   1/1     Running   0          72s   10.42.0.96   k3d-tomcat-server-0   <none>           <none>
tomcat-0   1/1     Running   0          60s   10.42.0.97   k3d-tomcat-server-0   <none>           <none>

# access test session ap via traefik
INGRESS_IP=$(k get node k3d-tomcat-server-0 -o jsonpath="{.status.addresses[0].address}")
COOKIE="Cookie: $(curl -k -i -s --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/ |grep set-cookie  | awk 'BEGIN { FS="[ ]" } ; { print $2 }' |tr -d "\n")"

# Create Session
curl -v -k -H "${COOKIE}" --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/
# Modify session
curl -v -k -H "${COOKIE}" --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/\?name\=hello
# Review
curl -v -k -H "${COOKIE}" --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/

# Cookie, Date
k exec -it tomcat-1 -c tomcat -- tail logs/localhost_access_log.2024-03-10.txt
# Strip Ingress Affinity Cookie tomcat
COOKIE="Cookie: $(echo $COOKIE | awk 'BEGIN { FS="[;]" } ; { print $2 }')"
echo $COOKIE
Cookie: JSESSIONID=58FD447D41B08FF87D25B5A5DD962D46.tomcat-1

curl -v -k -H "${COOKIE}" --resolve "tomcat.dev:443:${INGRESS_IP}" https://tomcat.dev:443/
10.42.0.8 - - [10/Mar/2024:05:09:10 +0000] "GET / HTTP/1.1" 200 179 360B86F7B47D38EC55D326DB40D68243.tomcat-2 - 521227e
k exec -it tomcat-2 -c tomcat -- /bin/bash
# https://jolokia.org/reference/html/manual/jolokia_protocol.html
# Use !/ as escape character

curl -s -u jolokia:jolokia \
  '127.0.0.1:8080/jolokia/read/Catalina:type=Manager,host=localhost,context=!//sessionCounter' | jq -r .value
docker 
k exec -it tomcat-0 -c tomcat -- /bin/bash -c "curl -s 127.0.0.1:8081/metrics | grep sessioncounter"
# HELP tomcat_session_sessioncounter_total Tomcat session sessionCounter total
# TYPE tomcat_session_sessioncounter_total counter
tomcat_session_sessioncounter_total{context="/",host="localhost",} 1.0
tomcat_session_sessioncounter_total{context="/jolokia",host="localhost",} 0.0
k exec -it tomcat-1 -c tomcat -- /bin/bash -c "curl -s 127.0.0.1:8081/metrics | grep sessioncounter"
k exec -it tomcat-2 -c tomcat -- /bin/bash -c "curl -s 127.0.0.1:8081/metrics | grep sessioncounter"

k port-forward pod/tomcat-1 8008:8008 &

# Dev Machine jconsole with and labctl tunnnel (untested)
labctl port-forward --machine node-01 --local node-01:8008:127.0.0.1:8008

jconsole 127.0.0.1:8008
```

Troubleshooting:

```bash
k logs tomcat-0
k rollout restart sts tomcat

# nslookup is part of the dnsutils package in Ubuntu. To install it, run the following command:
apt update
apt install -y dnsutils

```

## JMX Access cli

- https://www.baeldung.com/jmx-mbean-shell-access
- http://crawler.archive.org/cmdline-jmxclient/
- https://github.com/eugenp/tutorials/tree/master/core-java-modules/core-java-perf
- https://jolokia.org

````bash  
artifact=jolokia-agent-war
version=2.2.9
wget https://repo1.maven.org/maven2/org/jolokia/$artifact/$version/$artifact-$version.war \
-O jolokia.war

# review Dockerfile
# add Stdout AccessLog
cd images/tomcat
docker build -t bee42/tomcat:11-jre21 .

# push to iximiuz lab registry
docker tag bee42/tomcat:11-jre21 registry.iximiuz.com/bee42/tomcat:11-jre21
docker push registry.iximiuz.com/bee42/tomcat:11-jre21

#k3d image import bee42/tomcat:11-jre21 -c tomcat 

curl -v -k -u jolokia:jolokia -H "${COOKIE}" --resolve "tomcat.dev:443:${INGRESS_IP}" \
  https://tomcat.dev:443/jolokia/read/java.lang:type=Runtime/Name

k exec -it tomcat-2 -c tomcat -- /bin/bash
curl -s -u jolokia:jolokia 127.0.0.1:8080/jolokia/read/java.lang:type=Runtime/Name
{"request":{"mbean":"java.lang:type=Runtime","attribute":"Name","type":"read"},"value":"1@tomcat-2","status":200,"timestamp":1710047771}

k port-forward pod/tomcat-2 8081:8080 &
# open http://127.0.0.1:8081/jolokia

Catalina<type=Manager, host=([-a-zA-Z0-9+&@#/%?=~_|!:.,;]*[-a-zA-Z0-9+&@#/%=~_|]), context=([-a-zA-Z0-9+/$%~_-|!.]*)><>(processingTime|sessionCounter|rejectedSessions|expiredSessions):'

```

Configuration

* https://tomcat.apache.org/tomcat-8.5-doc/config/systemprops.html
  * jvmRoute

Implemetations

* https://github.com/apache/tomcat/blob/main/java/org/apache/catalina/tribes/membership/cloud/CloudMembershipService.java
* https://github.com/apache/tomcat/blob/main/java/org/apache/catalina/tribes/membership/cloud/DNSMembershipProvider.java
* https://github.com/apache/tomcat/blob/main/java/org/apache/catalina/tribes/membership/cloud/KubernetesMembershipProvider.java

Parameter:

OPENSHIFT_KUBE_PING_

OPENSHIFT_KUBE_PING_MASTER_PROTOCOL_KUBERNETES_MASTER_PROTOCOL=https
OPENSHIFT_KUBE_PING_MASTER_HOST_KUBERNETES_SERVICE_HOST=kubernetes.default.svc
OPENSHIFT_KUBE_PING_MASTER_PORT_KUBERNETES_SERVICE_PORT=443
OPENSHIFT_KUBE_PING_NAMESPACE_KUBERNETES_NAMESPACE=tomcat

# labelSelector=
OPENSHIFT_KUBE_PING_LABELS_KUBERNETES_LABELS=app=tomcat


Todo

- PodDisruptionBudget =1
- Wunderbox service thockin nachlesen udn warum das Gateway api viel besser ist....
- Stdout Access log...
- Anfänger, Wenn der Token nach zwei Stunden abläuft geht nix mehr....
  - Token wird nach einem Fehler nicht erneute gelesen. 
  - Bessere Compensation erzeugen.
  - Class support
    - Statische Token oder Client Cert
    - Rotation des Secrets bedeutet neustart des Nodes.
 
```text
  09-Mar-2024 17:50:18.992 SEVERE [Catalina-utility-1] org.apache.catalina.tribes.membership.cloud.KubernetesMembershipProvider.fetchMembers Failed to open stream
        java.io.IOException: Failed connection to [https://10.43.0.1:443/api/v1/namespaces/tomcat/pods] with token [eyJhbGciOiJSUzI1NiIsImtpZCI6ImRtcm9JVU5yQnZWbTQzeTRMUmtrSTlMLUNaZWI4Q0tJQXlkUUJTdUlrcDQifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiLCJrM3MiXSwiZXhwIjoxNzA5OTkxNzU4LCJpYXQiOjE3MDk5ODQ1NTgsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJ0b21jYXQiLCJwb2QiOnsibmFtZSI6InRvbWNhdC0xIiwidWlkIjoiZWUyMmFmMzUtMmZmMS00NzYxLTgwNWQtNDJlMGJhYjMwNjBlIn0sInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJ0b21jYXQiLCJ1aWQiOiI0NGQ1NGI3ZS1kMTgzLTRhZjgtOGYxYi0zNTNiNzM4YWZkN2MifX0sIm5iZiI6MTcwOTk4NDU1OCwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50OnRvbWNhdDp0b21jYXQifQ.X0VvObaM87h1ARvtCca9Yco95ndefwPO4WiR-2k23UkWczqvZwefg8hrOw2Pc6QY9NgzLQYDhxwExrQywZYg0p0vwIC6fwnMFRpp067FubUmJSx-OlkVzr4bfg0-YxFgGWn_guMyB7AaAiAxm4uIeTCkIbxDUPvyyrCo_wVGu68X3dk6omJLjHDf-FqJORZevOM5VIvrXZqEQQTf9DE6Equgchaax7l2lJTDWsc_bQD0PpcpaMJLfH-YcuBcgeD79ye0G5c_Yym_EFq1p1LFPyEDZz83J8196CYXc0e4ZTq7mJftzVeYjZcjkHGC-29aJRSKklbsyOQl376oqzbKpw]
                at org.apache.catalina.tribes.membership.cloud.TokenStreamProvider.openStream(TokenStreamProvider.java:56)
                at org.apache.catalina.tribes.membership.cloud.KubernetesMembershipProvider.fetchMembers(KubernetesMembershipProvider.java:140)
                at org.apache.catalina.tribes.membership.cloud.CloudMembershipProvider.heartbeat(CloudMembershipProvider.java:127)
                at org.apache.catalina.tribes.group.GroupChannel.heartbeat(GroupChannel.java:210)
                at org.apache.catalina.tribes.group.GroupChannel$HeartbeatRunnable.run(GroupChannel.java:843)
                at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Unknown Source)
                at java.base/java.util.concurrent.FutureTask.runAndReset(Unknown Source)
                at java.base/java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(Unknown Source)
                at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)
                at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
                at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:63)
                at java.base/java.lang.Thread.run(Unknown Source)
        Caused by: java.io.IOException: Server returned HTTP response code: 401 for URL: https://10.43.0.1:443/api/v1/namespaces/tomcat/pods
                at java.base/sun.net.www.protocol.http.HttpURLConnection.getInputStream0(Unknown Source)
                at java.base/sun.net.www.protocol.http.HttpURLConnection.getInputStream(Unknown Source)
                at java.base/sun.net.www.protocol.https.HttpsURLConnectionImpl.getInputStream(Unknown Source)
                at org.apache.catalina.tribes.membership.cloud.AbstractStreamProvider.openStream(AbstractStreamProvider.java:117)
                at org.apache.catalina.tribes.membership.cloud.TokenStreamProvider.openStream(TokenStreamProvider.java:53)
                ... 11 more
```
