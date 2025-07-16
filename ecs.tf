resource "aws_ecs_cluster" "app_cluster" {
  name = "anjali-fargate-cluster"
}

resource "aws_ecs_task_definition" "app_task" {
  family                   = "anjali-fargate-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.codebuild_role.arn

  container_definitions = jsonencode([
    {
      name      = "my-app"
      image     = "910490057036.dkr.ecr.us-east-1.amazonaws.com/my-tf-repo:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app_service" {
  name            = "anjali-fargate-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-06b6e2917496e5ad1", "subnet-07f322bebff080e25"]
    security_groups  = ["sg-057f1cfabf1a96b04"]
    assign_public_ip = true
  }
}
