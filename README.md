# Personal Website

My personal website is hosted on Google Cloud Platform.

Resources are managed using [Terraform][1]


## GCP

+ Enabled APIs and Services:

  1. Computer Engine API

  2. Identity and Access Management (IAM) API

+ Custom service account (with JSON key) having restricted roles for IaC automation:

  1. Compute Admin

  2. Service Account User


## Runbook

+ Set environment variables

  `source env.txt`

+ Initialize Terraform

  `terraform init -upgrade`

+ Validate existing configuration

  `terraform validate`

+ Create cloud resources

  `terraform apply --auto-approve`

+ Add the instance's external IP (from the console output) as an "A" record in Google Domains (domain registrar) for hostnames:

  1. saurabh.cc
  2. www<nowiki/>.saurabh<nowiki/>.cc


## Resources

+ [Apache Webserver on Ubuntu][3]
+ Certbot: [on Ubuntu][2] and [Automation Manual][4]

[1]: https://www.terraform.io/
[2]: https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-18-04
[3]: https://certbot.eff.org/instructions?ws=apache&os=ubuntufocal
[4]: https://manpages.ubuntu.com/manpages/bionic/en/man1/certbot.1.html
