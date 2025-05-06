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

FROM alpine:3.21

# Set environment variables
ARG EXPORTER_VERSION=1.0.10 
ARG TARGETPLATFORM
ARG TARGETARCH

# Install curl and ca-certificates to download and verify binaries
RUN apk add --no-cache curl ca-certificates

# Download and install apache_exporter
RUN curl -L https://github.com/Lusitaniae/apache_exporter/releases/download/v${EXPORTER_VERSION}/apache_exporter-${EXPORTER_VERSION}.linux-${TARGETARCH}.tar.gz \
    | tar -xz && \
    mv apache_exporter-${EXPORTER_VERSION}.linux-${TARGETARCH}/apache_exporter /usr/local/bin/ && \
    chmod +x /usr/local/bin/apache_exporter && \
    rm -rf apache_exporter-${EXPORTER_VERSION}.linux-${TARGETARCH}

# Create a non-root user (optional)
RUN adduser -D exporter
USER exporter

# Export metrics port
EXPOSE 9117

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/apache_exporter"]
