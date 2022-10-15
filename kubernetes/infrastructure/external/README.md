## Overview ##
Files within this folder are exclusively used for managing external connectivity to the kubernetes cluster from the internet.

All resources are located within the same namespace for RBAC/isolation purposes.
Both cloudflared and external-dns require credentials to cloudflare.

## How it works ##
1. Cloudflared - Create a tunnel from CF to the origin - mitigating having to portforward 443.
2. External-DNS - Creates CNAME DNS records pointing to a `*.cfargotunnel.com` url. This makes traffic traverse the tunnel.

## Initial Setup Steps ##

### 1. Cloudflare Zero Trust ###

*** Note: This step is normally last but let's set first .. for good reasons.. *** 

*"The internet's a nasty place, dont deploy ANYTHING unauthenticated to the internet!"* - Abraham Lincoln

This step forces a user prior to accessing a resource to do the OAUTH dance and confirm they have access.

Follow steps in:
1. [Self-Hosted Application](https://developers.cloudflare.com/cloudflare-one/applications/configure-apps/self-hosted-apps/ "Create Self-Hosted Application"). 
    1. It's recommended to set a wildcard `*` in the **application domain** field so all traffic going to the domain is authed - or add each new subdomain as required.
2. Next up add some [SSO integration](https://developers.cloudflare.com/cloudflare-one/identity/idp-integration/ "Integrate Single Sign-On").

!! Don't continue until these steps are complete !!

### 2. Cloudflared ###
This sets up the tunnel from CloudFlare <--> K8s

1. Manually install cloudflared, create initial tunnel structure and generate credentials json.  
    1. Leverage steps in https://developers.cloudflare.com/cloudflare-one/tutorials/many-cfd-one-tunnel/ 
    2. **Note** local cloudflared install isn't needed after this step but is useful for troubleshooting
2. Take credential .json file, save contents into keyvault.
3. Follow steps in https://github.com/cloudflare/argo-tunnel-examples/tree/master/named-tunnel-k8s to launch cloudflared.
4. Launch tunnel and confirm is operational.

### 3. External-DNS ###
Creates example.com CNAME entries pointing to a `*.cfargotunnel.com` record. These records are the magic glue that make the requests to a dns record leverage the cloudflared tunnel.

Using kind=service with type=externalname as ingress can't handle cname creation (afaik).

## Allowing new sites to leverage CloudFlare Tunnel ##
As we're dealing with the internet we want to make this a deliberate process for new sites. 

For each new url:
1. (clickops) If not using wildcard filtering - Ensure CloudFlare Zero Trust has a self-hosted application covering the new url.
2. Ensure the appropriate ingress is being used (only 1 ingress is allowed to be externally accessible). The Ingress ingressClassName must be set to *nginx*.
3. Cloudflared is set to only allow traffic from specific *example.domain.com* subdomains through the tunnel.
    1. Update *cloudflared-config* ConfigMap with new domain entry - **external/cloudflared-config.yaml**. Deploying update will force cloudflared to redeploy.
4. Create an external record - **external/external-records.yaml**.

## Further Information ##
* [Expose kubernetes service via CloudFlare argo tunnel](https://letsdocloud.com/2021/06/expose-kubernetes-service-using-cloudflare-argo-tunnel/)
* [Remotely access your kubernetes lab with CloudFlare tunnel](https://blog.marcolancini.it/2021/blog-kubernetes-lab-cloudflare-tunnel/)
* [Say goodbye to reverse proxy and hello to CloudFlare tunnels](https://noted.lol/say-goodbye-to-reverse-proxy-and-hello-to-cloudflare-tunnels/)
* [Ingress Rules - CloudFlare](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/local/local-management/ingress)
