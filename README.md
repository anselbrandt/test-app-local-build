# Dokku Test-App Deploying to Digitalocean

This repo uses the [dokku-deploy-action](https://github.com/marketplace/actions/dokku-deploy-action) workflow.

On `git push` a Github Action will be triggered to deploy this application to an existing Digitalocean Droplet.

Domain, proxying and SSL certificates should already be set up, and the application must be created.

This application deploys to the root domain.

```
dokku apps:create <app-name>
dokku domains:clear-global
dokku domains:set <app-name> <domain>
dokku proxy:ports-set <app-name> http:80:<port-exposed-by-docker-container>
```

### SSL Certs

If adding an existing cert/key pair, they must be named `server.crt` and `server.key` and put in a `.tar` file named `cert-key.tar` then uploaded to your Droplet.

```
tar cvf cert-key.tar server.crt server.key
scp cert-key.tar root@<domain.tld>:/root
```

In your Droplet:

```
dokku certs:add <app-name> < cert-key.tar
```

Alternatively, you can use the [dokku-letsencrypt](https://github.com/dokku/dokku-letsencrypt) pluggin.

\*letsencrypt will rate limit to 5 API calls per 7 day period.

### Config

`.github/workflows/dokku.yml` must point to the correct branch (eg. master or main), `dokku-host` (domain), and `app-name`

### Github

An SSH key with access to your Droplet will need to be added to Repository Secrets as `SSH_PRIVATE_KEY`

### Notes

This workflow builds your image locally.

The standard workflow builds images on your Droplet.

[https://github.com/anselbrandt/test-app](https://github.com/anselbrandt/test-app)
