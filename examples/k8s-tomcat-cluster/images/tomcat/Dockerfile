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
ARG TOMCAT_IMAGE=${TOMCAT_IMAGE:-tomcat:11-jre21}

FROM maven:3.9.9-eclipse-temurin-21-jammy AS valves
WORKDIR /valves
COPY bee42-tomcat-valves/pom.xml pom.xml
COPY bee42-tomcat-valves/src src/
RUN --mount=type=cache,target=/root/.m2 mvn -f pom.xml package -DskipTests

FROM alpine:3.21 as jolokia
ENV JOLOKIA_NAME=jolokia-agent-war
ARG JOLOKIA_VERSION=${JOLOKIA_VERSION:-2.2.9}
RUN wget https://repo1.maven.org/maven2/org/jolokia/$JOLOKIA_NAME/$JOLOKIA_VERSION/$JOLOKIA_NAME-$JOLOKIA_VERSION.war \
    -O /jolokia.war

FROM ${TOMCAT_IMAGE}
COPY --from=valves /valves/target/bee42-tomcat-valves.jar /usr/local/tomcat/lib
COPY --from=jolokia /jolokia.war /usr/local/tomcat/webapps/jolokia.war
