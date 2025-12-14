locals {
  bucket_name = "bucket-${var.environment}-${random_id.random.hex}-${var.region}"
  vpc_name = "${var.environment}-vpc"
}