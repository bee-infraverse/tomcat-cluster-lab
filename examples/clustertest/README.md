# Cluster test

Example show simple Tomcat HA Cluster replication feature!

```shell
mvn clean package
docker compose build
docker compose up -d
docker compose ps
docker compose up --scale tomcat=2 -d
docker compose logs --index=2 tomcat
docker compose exec --index=1 tomcat /bin/bash
docker restart clustertest-tomcat-1
curl -iL http://$(docker compose port --index=1 tomcat 8080)/clustertest
curl -iL --user jolokia:jolokia http://$(docker compose port --index=1 tomcat 8080)/jolokia
curl -iL --user jolokia:jolokia http://$(docker compose port --index=1 tomcat 8080)/jolokia/read/java.lang:type=Runtime/Name
```

Session Migration szenario:

```shell
docker compose build
docker compsoe up -d
docker compose port --index=1 tomcat 8080
# open browser an set hello vars....
# http://127.0.0.1:64414/clustertest/
docker compose up --scale tomcat=2 -d
docker compose port --index=2 tomcat 8080
# open browser an set hello vars....
# set correct port...
# http://127.0.0.1:63614/clustertest/

docker compose logs --index 2 --no-log-prefix tomcat 
```

* Access one tomcat with http://<ip>:<port>/ClusterTest
* See session replication
* Stop primary tomcat and restart
* Access same session again....

Now you need a loadbalancer with AJP or HTTP

Based on  tomcat 11 distribution!

* add jmx-exporter
* add jolkia support
* tomcat session  replication  cluster

```xml
   <Engine name="Catalina" defaultHost="cluster" jvmRoute="node1">
      <Cluster className="org.apache.catalina.ha.tcp.SimpleTcpCluster"
               channelSendOptions="6" channelStartOptions="3">
        <Manager className="org.apache.catalina.ha.session.DeltaManager"
                 expireSessionsOnShutdown="false" notifyListenersOnReplication="true" />
        <Channel className="org.apache.catalina.tribes.group.GroupChannel">
          <Receiver className="org.apache.catalina.tribes.transport.nio.NioReceiver"
                    autoBind="0" selectorTimeout="5000" maxThreads="6"
                    address="10.0.0.111" port="4444"
          />
          <Sender className="org.apache.catalina.tribes.transport.ReplicationTransmitter">
            <Transport className="org.apache.catalina.tribes.transport.nio.PooledParallelSender" />
          </Sender>
          <Interceptor className="org.apache.catalina.tribes.group.interceptors.TcpPingInterceptor" />
          <Interceptor className="org.apache.catalina.tribes.group.interceptors.TcpFailureDetector" />
          <Interceptor className="org.apache.catalina.tribes.group.interceptors.MessageDispatch15Interceptor" />
          <Interceptor className="org.apache.catalina.tribes.group.interceptors.StaticMembershipInterceptor">
            <Member className="org.apache.catalina.tribes.membership.StaticMember" securePort="-1"
                    host="10.0.0.222" port="4444"
            />
            . . .
          </Interceptor>
        </Channel>
        <Valve className="org.apache.catalina.ha.tcp.ReplicationValve" filter=".*.gif;.*.jpg;.*.png;.*.css" />
        <Valve className="org.apache.catalina.ha.session.JvmRouteBinderValve" />
        <ClusterListener className="org.apache.catalina.ha.session.JvmRouteSessionIDBinderListener" />
        <ClusterListener className="org.apache.catalina.ha.session.ClusterSessionListener" />
      </Cluster>
```

## Listener

- https://www.digitalocean.com/community/tutorials/servletcontextlistener-servlet-listener-example

## Observabilty

- [jolokia project](https://github.com/jolokia/jolokia)
  - [Docs](https://jolokia.org)
- jmx export
- open telemetry auto instrumentation

Regards,
Peter (peter.rossbach@bee42.com)
