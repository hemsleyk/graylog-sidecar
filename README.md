# Graylog Sidecar
Docker image for Graylog Sidecar Collector using filebeat

## Sidecar and collector logging

Sidecar and collectors write log to `/var/log/graylog/collector-sidecar` with
default daily rotation and retention time of 7 days. By default, log directory
is inside the container. Add appropriate volume mount to store logs in host.

## Usage

The container uses environment variables to define the logfiles that are monitored and connection settings to the server running Graylog. Following parameters are available:

- GS_SERVER_URL *(REQUIRED)*
 - Graylog server url to connect to
- GS_SERVER_API_TOKEN *(REQUIRED)*
 - API Token generated in Graylog web UI for the builtin graylog-sidecar user
- GS_NODE_ID *(REQUIRED)*
 - Graylog Sidecar instance name
- GS_UPDATE_INTERVAL
 - seconds interval on how often the configuration is retrieved from Graylog server, default is 30
- GS_SEND_STATUS
 - enable sending collector status to server, default is true
- GS_TLS_SKIP_VERIFY
 - Ignore errors when the REST API was started with a self-signed certificate, default is false
- GS_LIST_LOG_FILES
 - list of container paths that contain the log files monitored, listings of these paths are periodically published to server, default is empty
 - Example: GS_LIST_LOG_FILES=['/var/log/apache2','/var/log/mariadb']

Also, the monitored folder needs to be mounted for the docker container. E.g. if you want to monitor host location /var/log/apache2, you should mount it as follows:

`docker run --env-file ./env.list -v /var/log/apache2:/host/var/log/apache2:ro -d digiapulssi/graylog-sidecar`

Example env.list configuration:
```
GS_SERVER_URL=http://graylog2:9000/api/
GS_NODE_ID=apache-server
```

Since Graylog Sidecar retrieves its configuration from Graylog server, a matching configuration needs to exist in the server side. In particular, each tag that is configured in the GS_TAGS variable needs to exist in the Graylog server Collectors configuration.
