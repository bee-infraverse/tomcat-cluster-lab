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

# Stage 1: Build stage
FROM python:3.13-slim AS builder
WORKDIR /app

# Install dependencies in a virtual environment
COPY requirements.txt .
RUN python3 -m venv /app/venv && \
    /app/venv/bin/pip install --disable-pip-version-check --no-cache-dir -r requirements.txt

# Stage 2: Runtime stage
FROM python:3.13-slim
WORKDIR /app

# Copy the virtual environment from the builder stage
COPY --from=builder /app/venv /app/venv

# Copy application code
COPY *.py .

# Set environment variables
ENV FLASK_APP=modjk-exporter.py
ENV PATH="/app/venv/bin:$PATH"

# Expose the application port
EXPOSE 9114

# Set the stop signal
STOPSIGNAL SIGINT

# Command to run the application
CMD [ "flask", "run", "--host=0.0.0.0", "--port=9114" ]