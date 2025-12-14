terraform{    
    backend "s3" {
        bucket = "mys3bucket-terraform-state"
        key   = "dev/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true // In built functionality now for s3 bucket, hence no need of DynamoDB table for state locking
    }
}
