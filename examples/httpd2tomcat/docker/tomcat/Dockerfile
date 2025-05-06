# Copyright 2025, bee42 solutions gmbh <peter.rossbach@bee42.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG JVM_IMAGE=${JVM_IMAGE:-eclipse-temurin:21-jre}

FROM alpine:3.21 AS download
# Download Jolokia and JMX Exporte
ENV JOLOKIA_NAME=jolokia-agent-war
ARG JOLOKIA_VERSION=2.2.9
ARG JMX_EXPORTER_VERSION=1.2.0
ARG OTEL_AGENT_VERSION=2.15.0

RUN apk add --no-cache curl
RUN curl -sL https://repo1.maven.org/maven2/org/jolokia/${JOLOKIA_NAME}/${JOLOKIA_VERSION}/${JOLOKIA_NAME}-${JOLOKIA_VERSION}.war \
  -o /jolokia.war
RUN curl -sL https://github.com/prometheus/jmx_exporter/releases/download/${JMX_EXPORTER_VERSION}/jmx_prometheus_javaagent-${JMX_EXPORTER_VERSION}.jar \
  -o /jmx_prometheus_javaagent.jar
RUN curl -sL https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v${OTEL_AGENT_VERSION}/opentelemetry-javaagent.jar \
  -o /opentelemetry-javaagent.jar

FROM ${JVM_IMAGE}
LABEL org.opencontainers.image.vendor="bee42 solutions gmbh"
LABEL org.opencontainers.image.authors="Peter Rossbach <peter.rossbach@bee42.com>"

RUN apt update && apt install -y --no-install-recommends \
    iproute2 \
    jq \
    && rm -rf /var/lib/apt/lists/*
RUN curl -sL https://downloads.apache.org/tomcat/tomcat-11/v11.0.6/bin/apache-tomcat-11.0.6.tar.gz -o /tmp/tomcat.tar.gz && \
    mkdir -p /opt/tomcat && \
    tar -xzf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm /tmp/tomcat.tar.gz \
    rm -rf /opt/tomcat/webapps/* \
    rm /opt/tomcat/bin/*.bat \
    rm /opt/tomcat/bin/*.tar.gz

COPY --from=download /jmx_prometheus_javaagent.jar /opt/tomcat/lib/jmx_prometheus_javaagent.jar    
COPY --from=download /opentelemetry-javaagent.jar /opt/tomcat/lib/opentelemetry-javaagent.jar   
COPY --from=download /jolokia.war /opt/tomcat/webapps/jolokia.war 

COPY conf/* /opt/tomcat/conf/
COPY bin/* /opt/tomcat/bin/
COPY lib/*.jar /opt/tomcat/lib

WORKDIR /opt/tomcat

EXPOSE 8004
EXPOSE 8009
EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
