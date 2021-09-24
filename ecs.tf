resource "aws_ecs_cluster" "ugajin_cluster" {
  name = "ugajin-cluster"

  # CloudWatch Container Insightsの有効化
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "ugajin_task_definition" {
  family = "web"

  container_definitions = jsonencode([
    {
      name         = "nginx"
      image        = "nginx:latest"
      cpu          = 10
      memory       = 512
      essential    = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}