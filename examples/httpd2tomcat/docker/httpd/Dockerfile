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
FROM debian:bookworm-slim

RUN apt-get update -y && apt-get install -y \
    apache2 libapache2-mod-jk curl tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD jk.conf /etc/apache2/mods-enabled/jk.conf
ADD workers.properties /etc/libapache2-mod-jk/workers.properties

EXPOSE 80

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
