# INSTALL STEPS

1. Manually install ubuntu with username of ubuntu
    1. setup static IP

**Run following steps from local workstation**

2. Run `make pre-setup`
3. Paste in azure_client_id, azure_secret, azure_tenant and azure_keyvault variables
    1. clientid and clientsecret are from app-kubernetes-keyvault-prod. Manually generate and stored in bitwarden
4. Run `make ansible-k3s`
    1. Installs pre-requirements
    2. Installs k3s
    3. Installs longhorn, prometheus crds and metallb
        1. Installed at this stage as apps installed thru flux require these dependencies to be available.
    4. Creates secrets namespace and populates azure creds needed for external-secrets operator
    5. (master node) Installs NUT Controller, shutdown script and pushover notifier
        1. Remaining servers will only get NUT subscriber config
5. Can now run flux setup.
    1. Ensure `github_target_path` value is correct in `ansible/inventory/inventory.yml`
    2. Run `make ansible-flux` to install Flux to Kubernetes cluster
6. Confirm via flux url deployments occur.

## OS PATCHING
**Run all steps from local workstation**

1. Run `make ansible-node-patch`
2. Wait 15minutes
3. Confirm k8s nodes come back online

# UPGRADE STEPS
**Run all steps from local workstation**

## Kubernetes Upgrade
1. Paste in azure_client_id, azure_secret, azure_tenant and azure_keyvault variables
2. Update `k3s_release_version` in `ansible/inventory/inventory-prod.yml`
3. Update Kubernetes, run `make ansible-k3s-prod`

## Flux Upgrade
1. Paste in azure_client_id, azure_secret, azure_tenant and azure_keyvault variables
2. Update `flux_version` and `weave_gitops_version` values in `ansible/inventory/inventory-prod.yml`
3. Update Flux, run `make ansible-flux-prod`

## Longhorn Upgrade
1. Read doco for any changes
2. Upgrade longhorn `k3s_server_manifests_urls` value in `ansible/roles/k3s/vars/main.yml`
3. Run `make ansible-k3s-prod`
4. Confirm upgrade was successful and new version is running (check longhorn mgmt url)
5. When complete search repo and update `engineImage` value to new version
6. Raise a PR and redeploy
