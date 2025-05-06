#!/bin/bash

# Signal-Handler definieren
handle_signal() {
  echo "Signal received, httpd are stopped..." >> /var/log/entrypoint.log
  apachectl stop
  exit 0
}

# Signale abfangen
trap 'handle_signal' SIGTERM SIGINT

# Vorhandene Bereinigung
rm -rf /run/apache/* /tmp/apache*

# Apache im Vordergrund starten
apachectl -DFOREGROUND &

# Warten, bis ein Signal empfangen wird
wait $!