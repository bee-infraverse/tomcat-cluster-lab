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
ARG KUBECTL_VERSION=${KUBECTL_VERSION:-v1.29.2}
FROM debian:12 as base
RUN apt-get -y -qq -o Dpkg::Use-Pty=0 update && \
    apt-get -y -qq -o Dpkg::Use-Pty=0 -y install \
	    bash \
	    grep \
	    sed \
	    gawk \
	    coreutils \
			iproute2 \
			procps \
			curl \
	    jq \
	    diffutils && \
    rm -rf /var/lib/apt/lists/*

FROM registry.k8s.io/kubernetes/kubectl:${KUBECTL_VERSION} as kubectl

FROM scratch
COPY --from=base / /
COPY --from=kubectl /bin/kubectl /bin/kubectl
