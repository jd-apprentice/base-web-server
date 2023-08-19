terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
  }
}

/*
* [READ](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* Here we are setting up the provider for AWS, this is the service we are going to use to create our infrastructure.
* Remember to store your credentials in a safe place, in this case we are using the credentials of the root user, but it is recommended to create a user with the necessary permissions and use those credentials.
*/

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}
