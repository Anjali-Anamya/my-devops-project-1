
resource "aws_s3_bucket" "artifact_store" {
  bucket = "anjali-artifact-store-bucket"
  force_destroy = true
}
resource "aws_s3_bucket_public_access_block" "artifact_store_block" {
  bucket                  = aws_s3_bucket.artifact_store.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
