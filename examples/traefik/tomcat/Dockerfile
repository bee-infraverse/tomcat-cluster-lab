# Copyright 2024, bee42 solutions gmbh <peter.rossbach@bee42.com
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
ARG TOMCAT_IMAGE=${TOMCAT_IMAGE:-tomcat:11-jre21}

FROM alpine:3.21 as jolokia
ENV JOLOKIA_NAME=jolokia-agent-war
ARG JOLOKIA_VERSION=${JOLOKIA_VERSION:-2.2.9}
RUN wget https://repo1.maven.org/maven2/org/jolokia/$JOLOKIA_NAME/$JOLOKIA_VERSION/$JOLOKIA_NAME-$JOLOKIA_VERSION.war \
    -O /jolokia.war

FROM ${TOMCAT_IMAGE}
RUN rm -rf /usr/local/tomcat/webapps/*
COPY bin/* /usr/local/tomcat/bin/
COPY conf/* /usr/local/tomcat/conf/
COPY webapps/hello /usr/local/tomcat/webapps/ROOT
COPY --from=jolokia /jolokia.war /usr/local/tomcat/webapps/jolokia.war
EXPOSE 8009
EXPOSE 8080
