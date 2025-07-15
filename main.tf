provider "aws" {
  region = "us-east-1"
}

resource "aws_codestarconnections_connection" "github" {
  name          = "anjali-github-connection"
  provider_type = "GitHub"
}

output "codestar_connection_arn" {
  value = aws_codestarconnections_connection.github.arn
}