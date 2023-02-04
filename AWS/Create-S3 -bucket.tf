
# Declaring the Provider Requirements
# Line 9 - version 3.0 is the latest  as of 04/02/2023 although this could change in the future

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configuring the AWS Provider (aws) with region set to 'us-east-2'
# configures with access and secret key for programatic access
provider "aws" {
  region = "us-east-2"
   access_key = "PUT-YOUR-ACCESS-KEY-HERE"
  secret_key = "PUT-YOUR-SECRET-KEY-HERE"
}

# Creating the encryption key which will encrypt the bucket objects
# The "mykey is an alias and can be changed"
resource "aws_kms_key" "mykey" {
  deletion_window_in_days = "20"
}

# Granting the Bucket Access
# It is best practise to block public access on a bucket
resource "aws_s3_bucket_public_access_block" "publicaccess" {
  bucket = aws_s3_bucket.test.id
  block_public_acls = false
  block_public_policy = false
}

# Creating the S3 Bucket and apply encryption
resource "aws_s3_bucket" "test" {
## Change the "bucket" name into a unique value before provisioning.
bucket = "terraform-demo"
        force_destroy = false
server_side_encryption_configuration {
rule {
apply_server_side_encryption_by_default {
kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm = "aws:kms"
}
}
  }
  # Keeping multiple versions of an object in the same bucket
  versioning {
    enabled = true
  }
}