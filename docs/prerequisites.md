# PREREQUISITES

The following is required for a successful deployment:

## Authentication

Uses the repo [kubernetes-homelab-azure](https://github.com/cfergs/kubernetes-homelab-azure) to create the following Azure AD applications.

| Application                         | Use                                                       |
|-------------------------------------|-----------------------------------------------------------|
| app-flux-dashboard-homelab-prod     | AzureAD authentication to Flux Dashboard                  |
| app-grafana-dashboard-homelab-prod  | AzureAD authentication to Grafana Dashboard               |
| app-kubernetes-keyvault-prod        | Allow Kubernetes to pull secrets from Azure Keyvault      |

## Azure Keyvault

TF values managed using the repo [kubernetes-homelab-azure](https://github.com/cfergs/kubernetes-homelab-azure) and [cloudflare-terraform](https://github.com/cfergs/cloudflare-terraform).

* Secrets imported into kubernetes using external-secrets operator (ESO).
* ESO checks for updated secrets every 24hrs. Can manually trigger refresh with `kubectl annotate es my-es force-sync=$(date +%s) --overwrite`
* Reloader (where possible) is used to force pod redeployments when secrets change.

The following secrets are required in an Azure Keyvault:

| Secret                               | Use                                              | Creation   |
|--------------------------------------|--------------------------------------------------|------------|
| azuread-tenantid                     | AzureAD tenantid                                 | Terraform  |
| cloudflare-api-token                 | cert-manager letsencrypt                         | Manual     |
| cloudflare-tunnel-token              | Cloudflare tunnel (created by CF tunnel repo)    | TF - other |
| github-token                         | PAT token for flux                               | Manual     |
| grafana-admin-password               | grafana admin password                           | Terraform  |
| grafana-dashboard-app-clientid       | app-grafana-dashboard-homelab-prod clientid      | Terraform  |
| grafana-dashboard-app-clientsecret   | app-grafana-dashboard-homelab-prod clientsecret  | Terraform  |
| homelab-domainname                   | domainname for environment                       | Terraform  |
| longhorn-blob-account-key            | longhorn storage account key                     | Terraform  |
| longhorn-blob-storage-account        | longhorn storage account name                    | Terraform  |
| mikrotik-prometheus-password         | RO login to get mikrotik prometheus metrics      | Manual     |
| nordvpn-password                     | download VPN creds                               | Manual     |
| nordvpn-username                     | download VPN creds                               | Manual     |
| nut-user-controller-password         | NUT controller password                          | Terraform  |
| nut-user-subscriber-password         | NUT subscriber password                          | Terraform  |
| prometheus-blob-account-key          | prometheus (thanos) storage account key          | Terraform  |
| prometheus-blob-storage-account      | prometheus (thanos) storage account name         | Terraform  |
| pushover-app-token                   | NUT alerting                                     | Manual     |
| pushover-app-user                    | NUT alerting                                     | Manual     |
| splunk-admin-password                | splunk admin account password                    | Terraform  |
| splunk-blob-account-key              | splunk smartstore/app storage account key        | Terraform  |
| splunk-blob-storage-account          | splunk smartstore/app storage account name       | Terraform  |
| splunk-enterprise-license            | Splunk license                                   | Manual     |
| splunk-hec-token                     | splunk hec token                                 | Terraform  |
| splunk-idxc-secret                   | splunk idxc secret                               | Terraform  |
| splunk-pass4SymmKey                  | splunk password for symmkey                      | Terraform  |
| splunk-shc-secret                    | splunk shc secret                                | Terraform  |
| weave-gitops-app-clientid            | app-flux-dashboard-homelab-prod clientid         | Terraform  |
| weave-gitops-app-clientsecret        | app-flux-dashboard-homelab-pord clientsecret     | Terraform  |

## Azure Storage

Offsite storage. Managed using the repo [kubernetes-homelab-azure](https://github.com/cfergs/kubernetes-homelab-azure).

Used by:
* Longhorn volume backups
* Splunk smartstore and app storage
* Prometheus (Thanos) metrics

## CloudFlare

Uses:
* cert-manager to generate letsencrypt internal certs
* Cloudflare tunnel

Managed using the repo [cloudflare-terraform](https://github.com/cfergs/cloudflare-terraform).
In addition to managing CloudFlare, this repo also manage CloudFlare Tunnel config with ingress rules enabling external access to appropriate internal urls.

Cert-Manager Permissions: https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/

## GitHub

Create PAT (Fine Grained). Used by Flux.
Permissions:
* Administration - Read/Write
* Contents - Read/Write
* Metadata - Read
* Pull-Requests - Read/Write

## Pushover

Used for NUT UPS alerting. user and token stored in azure keyvault
