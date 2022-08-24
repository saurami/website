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


[1]: https://www.terraform.io/
