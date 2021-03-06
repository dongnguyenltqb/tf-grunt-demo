generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "s3" {
    bucket         = "dong-tfgrunt-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
  }
}
EOF
}

generate "" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.14.0"
    }
  }
}
provider "aws" {
  region = "ap-southeast-1"
}
EOF
}
