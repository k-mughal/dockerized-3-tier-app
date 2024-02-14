# Terraform Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 3.21" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
    
  access_key = "***"
  secret_key = "******"
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  #shared_credentials_files = ["$HOME/.aws/credentials"]
}
