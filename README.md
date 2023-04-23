# Personal GCP Squid Proxy

This is a VERY quick and dirty squid proxy in GCP. These instructions are not guaranteed to be complete or work, but if you're here and willing, I trust you have the know how to get past the mistakes in this.

## Pre Work
1. Set up GCP. Complete instructions [can be found here](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build), but the short version is this:
    1. Ensure you have a GCP account
    1. Ensure you have a Project within the GCP account you want to use
    1. Ensure you have a Service Account within the Project within the GCP account to use with Terraform
    1. Download the credentials json for the SA
1. Set up your local workspace, install ansible-playbook and terraform
    1. This was written using ansible-playbook version 2.9.6 and terraform version v1.4.5

## Work
1. Fill in the place holders in main.tf with your info
1. `terraform init`
1. `terraform apply`
1. Fill in the place holder in [hosts](hosts) with the external IP if your new GCP server
1. Fill in the place holders in squid.yaml with your info
1. `ansible-playbook -i hosts squid.yaml -u <YOUR USERNAME>`

## Post Work
1. Confirm working 
    1. ```curl -v -x http://<YOUR GCP SERVER IP>:3128 https://icanhazip.com```
    1. This should show you pass through your GCP server and it should respond with the IP of your GCP server
1. If working, set your system proxy and enjoy!

## Caveats
- for some reason, I couldn't get Firefox to play nice with this setup. I didn't dig that deep, though. Chrome worked fine, so I went on about my day. If you know why FF wasn't working or know how to get it working, feel free to submit an issue or PR here and I'll address it.