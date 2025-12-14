terraform {
    backend "s3" {
        bucket = "mys3bucket-terraform-state"
        key   = "dev/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true // In built functionality now for s3 bucket, hence no need of DynamoDB table for state locking
    }
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

variable "environment" {
    description = "The environment for AWS resources"
    type        = string
    default     = "dev"
}

variable "region" {
  description = "The name of region"
  type = string
  default = "us-east-1"
}

locals {
  bucket_name = "bucket-${var.environment}-${random_id.random.hex}-${var.region}"
  vpc_name = "${var.environment}-vpc"
}


resource "aws_vpc" "exm" {
    cidr_block = "172.0.0.0/16"
    region = var.region
    tags = {
        Name = local.vpc_name
        environment = var.environment
    }
}

resource "random_id" "random" {
  byte_length = 5
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = local.bucket_name
    tags = {
        Name = local.bucket_name
        environment = var.environment
    }
}

resource "aws_instance" "my-ec2" {
    ami           = "ami-068c0051b15cdb816" // Amazon Linux 2 AMI
    instance_type = "t2.micro"
    region = var.region
    tags = {
        Name = "${var.environment}-ec2-instance"
        environment = var.environment
    }
}

output "vpc_id" {
  value = aws_vpc.exm.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "ec2_instance_id" {
  value = aws_instance.my-ec2.id
}