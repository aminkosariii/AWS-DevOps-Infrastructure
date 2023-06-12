# Terraform and Bash scripts for GitLab on AWS

This repository contains Terraform code and a Bash script for deploying GitLab on an EC2 instance on AWS.


## Deployment

To deploy GitLab on AWS using Terraform and Bash, follow these steps:

1. Clone this repository to your local machine.
2. In the `terraform` directory, create a file named `terraform.tfvars` and add the following variables:

```
access_key = "<your AWS access key>"
secret_key = "<your AWS secret key>"
region     = "<the AWS region you want to deploy to>"
key_name   = "<the name of your SSH key pair>"
```

3. Initialize the Terraform project by running `terraform init`. This will download the necessary provider plugins.
4. Run `terraform apply` to deploy the EC2 instance and security group.
5. Once the EC2 instance is up and running, SSH into it using the private key from your SSH key pair. You can find the public IP of the instance in the output of the Terraform script.
6. Once you're logged in to the EC2 instance, run the `gitlab-runner-install.sh` script to install GitLab Runner.

## Cleaning up

To delete the resources created by Terraform, run `terraform destroy`. This will delete the EC2 instance and security group.

Note that this will not delete the SSH key pair you created earlier. You will need to delete this manually from the AWS console.
