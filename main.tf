resource "aws_vpc" "this" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  tags = { Name = "secure-three-tier" }
}

resource "aws_subnet" "app" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.20.10.0/24"
  map_public_ip_on_launch = false
  tags = { Tier = "application" }
}

resource "aws_subnet" "data" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.20.20.0/24"
  map_public_ip_on_launch = false
  tags = { Tier = "data" }
}

resource "aws_s3_bucket" "artifacts" { bucket_prefix = "secure-artifacts-" }
resource "aws_s3_bucket_public_access_block" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_server_side_encryption_configuration" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  rule { apply_server_side_encryption_by_default { sse_algorithm = "AES256" } }
}
resource "aws_s3_bucket_versioning" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  versioning_configuration { status = "Enabled" }
}
