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

FROM maven:3.9.6-eclipse-temurin-21 AS hello
WORKDIR /hello
COPY ./pom.xml pom.xml
COPY ./src src/
RUN --mount=type=cache,target=/root/.m2 mvn -f pom.xml package -DskipTests

# only war for volume mount
FROM scratch
COPY --from=hello /hello/target/ROOT.war /hello.war
CMD ["true"]