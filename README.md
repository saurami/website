# Personal Website

My personal website is hosted on Google Cloud Platform.

Resources are managed using [Terraform][1]

## Admin Console

+ In "APIs and Services" enable:

  + Computer Engine API
  + Identity and Access Management (IAM) API

+ In the "IAM and Admin" section:

  + Change project name (from "Settings")
  + Create a service account with key. **NOTE:** JSON key will be automatically downloaded
  + Add the following roles to the service account (from "IAM"):

  	1. Compute Admin
  	2. Service Account User

## CLI

+ [Install the GCloud CLI][2]

+ Initiate the CLI with cloud SDK

  `gcloud init`

+ Move the downloaded JSON key to `~/.config/gcloud/`

+ Set environment variable for shell

  `export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/service-account.json`


[1]: https://www.terraform.io/
[2]: https://cloud.google.com/sdk/docs/install
