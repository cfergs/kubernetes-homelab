# OTHER

## FORCE NODE REBOOT
**Run all steps from local workstation**

1. Run `make ansible-node-reboot`
2. Wait 5minutes
3. Confirm k8s nodes come back online

## Schemas

Refer to https://github.com/datreeio/CRDs-catalog.

Custom schemas reside in /schemas folder. Extracted using CRD Extractor

## Update Splunk License

Needed every 6months

* Login to Azure portal and open cloudshell
* Create license.lic
* az account set --subscription "Visual Studio Enterprise"
* az keyvault list
* az keyvault secret set --vault-name "vault-name" --name splunk-enterprise-license --file license.lic

## Upgrade splunk-syslog

Generated from a helm template. Unable to directy use helm because it requires the creation of a secret during helm install - i've pre-created secret already. As such run
* helm repo update splunk-connect-for-syslog
* helm template splunk-connect-for-syslog/splunk-connect-for-syslog -f values.yaml
* copy output to `syslog-install.yaml`.
  * retain any references to the namespace
  * remove the secret
  * remove any non 514 numbered ports from the service and statefulset
  * retain statefulset annotations
  * retain secretkey ref on env value SC4S_DEST_SPLUNK_HEC_DEFAULT_TOKEN
  * remove test connection pod

## Update pip requirements

* Update `requirements-pip.txt`
* Run `make refreeze-dev-requirements`
* Raise PR with changes
