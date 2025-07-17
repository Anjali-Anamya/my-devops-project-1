# ---------- KMS KEY ----------
resource "aws_kms_key" "s3_key" {
  description             = "KMS key for S3 bucket encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

# ---------- ARTIFACT STORE BUCKET ----------
resource "aws_s3_bucket" "artifact_store" {
  bucket        = "artifact-store-devops-project-dev"
  force_destroy = true

  tags = {
    Name        = "Artifact Store Bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "artifact_store_versioning" {
  bucket = aws_s3_bucket.artifact_store.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "artifact_store_block" {
  bucket = aws_s3_bucket.artifact_store.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact_store_encryption" {
  bucket = aws_s3_bucket.artifact_store.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_key.arn
    }
  }
}

resource "aws_s3_bucket_logging" "artifact_store_logging" {
  bucket        = aws_s3_bucket.artifact_store.id
  target_bucket = aws_s3_bucket.artifact_store_logs.id
  target_prefix = "logs/"

  depends_on = [
    aws_s3_bucket.artifact_store,
    aws_s3_bucket.artifact_store_logs
  ]
}

# ---------- LOGGING BUCKET ----------
resource "aws_s3_bucket" "artifact_store_logs" {
  bucket        = "artifact-store-logs-devops-project-dev"
  force_destroy = true

  tags = {
    Name        = "Artifact Store Logs Bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "artifact_store_logs_versioning" {
  bucket = aws_s3_bucket.artifact_store_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "artifact_store_logs_block" {
  bucket = aws_s3_bucket.artifact_store_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact_store_logs_encryption" {
  bucket = aws_s3_bucket.artifact_store_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3_key.arn
    }
  }
}

resource "aws_s3_bucket_logging" "artifact_store_logs_logging" {
  bucket        = aws_s3_bucket.artifact_store_logs.id
  target_bucket = aws_s3_bucket.artifact_store_logs.id
  target_prefix = "internal-logs/"
}
