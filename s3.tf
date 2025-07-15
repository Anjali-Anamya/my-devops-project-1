
resource "aws_s3_bucket" "artifact_store" {
  bucket = "anjali-artifact-store-bucket"
  force_destroy = true
}
