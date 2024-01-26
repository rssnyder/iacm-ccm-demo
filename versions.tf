terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      owner   = "riley.snyder@harness.io"
      ttl     = "-1"
      purpose = "demo"
      note    = "do not delete"
    }
  }
}
