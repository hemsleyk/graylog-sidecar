#########################
# graylog sidecar       #
#########################
FROM debian:10-slim
##support raspberry pi##

# Update and install some required dependencies
RUN apt-get update && apt-get install -y openssl libapr1 libdbi1 libexpat1 ca-certificates

# Install Graylog Sidecar (Filebeat included) ARM Edition
ENV SIDECAR_BINARY_URL https://github.com/Graylog2/collector-sidecar/releases/download/1.0.2/graylog-sidecar_1.0.2-1_armv7.deb
# Enable ARMhf
RUN dpkg --add-architecture armv7 && apt-get install -y --no-install-recommends curl && curl -Lo collector.deb ${SIDECAR_BINARY_URL} && dpkg -i collector.deb && rm collector.deb && apt-get purge -y --auto-remove curl

# Define default environment values
ENV GS_UPDATE_INTERVAL=30 \
    GS_SEND_STATUS="true" \
    GS_TLS_SKIP_VERIFY="false" \
    GS_LIST_LOG_FILES="[]" \

ADD ./data /data

CMD /data/start.sh
