# kubernetes-homelab
Kubernetes: The next generation

## Schemas

Refer to https://github.com/datreeio/CRDs-catalog.

Custom schemas reside in /schemas folder. Extracted using CRD Extractor

## Update Splunk License

Needed every 6months

* Login to Azure portal and open cloudshell
* Create license.lic
* az account set --subscription "Pay-As-You-Go"
* az keyvault list
* az keyvault secret set --vault-name "chickenwaffles-keyvault" --name splunk-enterprise-license --file license.lic
