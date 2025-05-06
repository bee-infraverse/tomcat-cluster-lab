# debug shell

## Usage

```shell
docker build --build-arg KUBECTL_VERSION=v1.29.2 -t bee42/debug-shell:v1.29.2 .
k3d image import --cluster tomcat bee42/debug-shell:v1.29.2
k create namespace debug
k ns debug
k apply -f debug.yaml
```

## References

- https://github.com/thockin/kubectl-sidecar
