output "vpc_id" {
  value = aws_vpc.exm.id
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "ec2_instance_id" {
  value = aws_instance.my-ec2.id
}