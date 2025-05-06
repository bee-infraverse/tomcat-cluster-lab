#!/bin/sh
export LC_ALL="en_US.utf-8"
export LANG="$LC_ALL"
export CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.port=8008 -Dcom.sun.management.jmxremote.rmi.port=8008 -Djava.rmi.server.hostname=127.0.0.1"
export JAVA_OPTS="${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom"
export JAVA_OPTS="${JAVA_OPTS} -Duser.language=en -Duser.country=US"
export CATALINA_OPTS="${CATALINA_OPTS} -XX:MaxRAMPercentage=70 -XX:MaxMetaspaceSize=256m -XX:+UseG1GC -XX:+UseStringDeduplication"

if [ "${JVM_ROUTE}z" = "z" ]; then
  TOMCAT_JVM_ROUTE=`hostname`
else
  TOMCAT_JVM_ROUTE=$JVM_ROUTE
fi

export CATALINA_OPTS="$CATALINA_OPTS -DjvmRoute=${TOMCAT_JVM_ROUTE}"
