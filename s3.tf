resource "aws_s3_bucket" "artifact_store" {
  bucket         = "anjali-artifact-store-bucket"
  force_destroy  = true
}

resource "aws_s3_bucket_public_access_block" "artifact_store_block" {
  bucket                  = aws_s3_bucket.artifact_store.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact_store_encryption" {
  bucket = aws_s3_bucket.artifact_store.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "artifact_store_logs" {
  bucket = "anjali-artifact-logs-bucket"
}

resource "aws_s3_bucket_logging" "artifact_store_logging" {
  bucket        = aws_s3_bucket.artifact_store.id
  target_bucket = aws_s3_bucket.artifact_store_logs.id
  target_prefix = "log/"
}

resource "aws_s3_bucket_versioning" "artifact_store_versioning" {
  bucket = aws_s3_bucket.artifact_store.id

  versioning_configuration {
    status = "Enabled"
  }
}
