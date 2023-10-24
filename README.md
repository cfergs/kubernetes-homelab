# kubernetes-homelab
Kubernetes: The next generation

## Overview

This is a mono repository for my home infrastructure and Kubernetes cluster. It's comprised of Infrastructure as Code (IaC) leveraging the following tools:
* [Ansible](https://www.ansible.com/)
* [Kubernetes](https://kubernetes.io/)
* [Flux](https://github.com/fluxcd/flux2)
* [GitHub Actions](https://github.com/features/actions)

## Directories

This Git repository contains the following directory structure.

```sh
📁 repo
├─📁 ansible           # Ansible code to bootstrap, install/upgrade k3s/flux
├─📁 kubernetes        # Kubernetes cluster defined as code
| ├─📁 apps            # User based applications
| ├─📁 clusters        # Cluster config and settings
| ├─📁 infrastructure  # Core applications - cert-manager, ingress, secrets etc
| ├─📁 monitor         # Apps for monitoring cluster or other resources
| ├─📁 namespaces      #
| ├─📁 networking      # Cloudflare, unifi and VPN
| └─📁 repositories    # helmrepositories
├─📁 schema
```

## Core Components

- [cert-manager](https://cert-manager.io/docs/): creates SSL certificates for services in my cluster
- [cloudflare-tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/): securely access url's externally
- [external-secrets](https://github.com/external-secrets/external-secrets/): managed Kubernetes secrets using Azure Key Vaults
- [ingress-nginx](https://github.com/kubernetes/ingress-nginx/): ingress controller for Kubernetes using NGINX as a reverse proxy
- [longhorn](https://longhorn.io): distributed peristent storage and creates backups to Azure Storage
- [metallb](https://metallb.universe.tf/): layer 2 load-balancer
- [splunk](https://splunk.com): log querying
- [prometheus](https://prometheus.io): query metrics, displayed using grafana

## Associated Repositories

* [cloudflare-terraform](https://github.com/cfergs/cloudflare-terraform): Manage external DNS and cloudflare-tunnels
* [kubernetes-homelab-azure](https://github.com/cfergs/kubernetes-homelab-azure): Manage azure storage and keyvault
* [network-automation](https://github.com/cfergs/network-automation): Manage mikrotik and wireless network config and internal DNS

## Documentation

* [PreRequisites](./docs/prerequisites.md)
* [Hardware](./docs/hardware.md)
* [Install/Upgrade Steps](./docs/install-upgrade.md)
* [Apps](./docs/apps.md)
* [Linting](./docs/linting.md)
* [Monitoring](./docs/monitoring.md)
* [Other](./docs/other.md)
