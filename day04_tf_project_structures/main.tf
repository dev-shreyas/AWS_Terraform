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