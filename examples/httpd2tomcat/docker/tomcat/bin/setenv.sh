#!/bin/sh
export LC_ALL="en_US.utf-8"
export LANG="$LC_ALL"
export CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.port=8008 -Dcom.sun.management.jmxremote.rmi.port=8008 -Djava.rmi.server.hostname=127.0.0.1"
export JAVA_OPTS="${JAVA_OPTS} -javaagent:/opt/tomcat/lib/jmx_prometheus_javaagent.jar=8004:/opt/tomcat/conf/jmx_config.yaml"
export JAVA_OPTS="${JAVA_OPTS} -javaagent:/opt/tomcat/lib/-javaagent:/opentelemetry-javaagent.jar"
export JAVA_OPTS="${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom"
export JAVA_OPTS="$JAVA_OPTS -Duser.language=en -Duser.country=US"

if [ "${JVM_ROUTE}z" = "z" ]; then
  if [ -S "/var/run/docker.sock" ]; then
    ROUTE=$(curl -s --unix-socket /var/run/docker.sock http://v1.42/containers/$(hostname)/json | jq -r .Name | sed 's/^.//')
  else
    ROUTE=
  fi
  if [ "${ROUTE}z" = "z" ]; then
    TOMCAT_JVM_ROUTE=`hostname`
  else
    TOMCAT_JVM_ROUTE=$ROUTE
  fi
else
  TOMCAT_JVM_ROUTE=$JVM_ROUTE
fi

export CATALINA_OPTS="$CATALINA_OPTS -DjvmRoute=${TOMCAT_JVM_ROUTE}"

# Set OTEL collector endpoint (replace with your actual collector host/port)
export OTEL_EXPORTER_OTLP_ENDPOINT=http://otel-collector:4317
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc

# Optional metadata
export OTEL_SERVICE_NAME=tomcat-cluster
export OTEL_RESOURCE_ATTRIBUTES=service.namespace=tomcat,host.name=${HOSTNAME},jvmRoute=${TOMCAT_JVM_ROUTE}


cat ${CATALINA_HOME}/bin/INFRAverse.txt
echo "     Power by Apache Tomcat"
echo "    https://tomcat.apache.org"
