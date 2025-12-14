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