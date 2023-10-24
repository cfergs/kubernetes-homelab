# MONITORING

Consists of:
* Logs: Splunk
* Metrics: Prometheus

## Splunk

Splunk monitors logs for kubernetes cluster using [signalfx](https://github.com/signalfx/splunk-otel-collector-chart) which uses otel to grab kubernetes logs and syslog using [splunk-connect-for-syslog](https://github.com/splunk/splunk-connect-for-syslog). Syslog is used to collect logs from my Mikrotik router and HPe switch.

Splunk uses an Azure container for its smartstore.

Splunk running using a developer license - requires updating every 6months - refer to [other](other.md).

URL: https://splunk.DOMAIN_NAME
HEC_URL: splunk-hec.DOMAIN_NAME

## Prometheus

Using [prometheus-community](https://github.com/prometheus-community/helm-charts) helm chart to configure prometheus, grafana and upload of metrics via thanos. [bitnami-thanos](https://github.com/bitnami/charts/tree/main/bitnami/thanos) does thanos querying, compacting and storegateway actions.

Prometheus monitors metrics for:
* cert-manager
* coredns
* external-secrets
* flux
* ingress
* kubernetes cluster
* longhorn
* metallb
* mikrotik router

Metrics are stored in Grafana. Dashboards are stored in code along with all config.

Prometheus uploads metrics older than 2hours to an azure container using Thanos. Thanos set as default datastore in grafana.

URL: https://grafana.DOMAIN_NAME. Accessible via AzureAd authentication

TL;DR. Prometheus-community chart manages prom/grafana & uploads metrics to thanos, Thanos chart manages cloud storage and makes metrics available for querying.

```text
                       +--------------+                  +--------------+      +--------------+
                       | Thanos       |----------------> | Thanos Store |      | Thanos       |
                       | Query        |           |      | Gateway      |      | Compactor    |
                       +--------------+           |      +--------------+      +--------------+
                                                  |             |                     |
                                                  |             | storages            | Downsample &
                                                  |             | query metrics       | compact blocks
                                                  |             |                     |
                                                  |             \/                    |
                                                  |      +----------------+           |
                                                  |----> | Azure          | <---------+
                                                  |      | Container      |
+------------------------------+                  |      +----------------+
|+------------+  +------------+|                  |
|| Prometheus |->| Thanos     || <----------------+
|| (*)        |<-| Sidecar (*)||    query
|+------------+  +------------+|    metrics
+------------------------------+
```
