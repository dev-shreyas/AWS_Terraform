    terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
        }

        random = {
            source = "hashicorp/random"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "exm" {
    cidr_block = "172.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
}

resource "random_id" "random" {
  byte_length = 5
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "bucket-${random_id.random.hex}"
}