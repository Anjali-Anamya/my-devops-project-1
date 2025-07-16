resource "aws_codebuild_project" "app_build" {
  name         = "anjali-codebuild"
  service_role = aws_iam_role.codebuild_role.arn

  source {
    type      = "GITHUB"
    location  = "https://github.com/Anjali-Anamya/my-devops-project-1"
    buildspec = "buildspec.yml"
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source_version = "main"
}