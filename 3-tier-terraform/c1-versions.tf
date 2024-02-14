# Terraform Block
# Terraform Settings Block - https://registry.terraform.io/providers/hashicorp/aws/latest
terraform {
  required_version = ">= 1.6" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = { # local name: are module specific and should be be unique per-module
      source  = "hashicorp/aws"
      version = ">= 5.0"  
    }
  }
}

# Provider Block
provider "aws" { # recommended way of choosing local is to use preferred local name of provider (AWS preferred local name is aws)
    
  access_key = "*****"
  secret_key = "*******************"
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = var.aws_region # defined in c2-generic-variables.tf
  #shared_credentials_files = ["$HOME/.aws/credentials"]
  # Section3: 20. Step: @ 3:45
}

