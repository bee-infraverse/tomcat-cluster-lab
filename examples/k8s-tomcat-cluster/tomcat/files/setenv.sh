#!/bin/sh
export LC_ALL="en_US.utf-8"
export LANG="$LC_ALL"
export CATALINA_OPTS="${CATALINA_OPTS} -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.port=8008 -Dcom.sun.management.jmxremote.rmi.port=8008 -Djava.rmi.server.hostname=127.0.0.1"
