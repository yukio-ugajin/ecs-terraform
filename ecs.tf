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
      name      = "nginx"
      image     = "nginx:latest"
      cpu       = 10
      memory    = 100
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = 80
          hostPort      = 0 # 動的ポートマッピング
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "ugajin_service" {
  name                              = "ugajin-service"
  cluster                           = aws_ecs_cluster.ugajin_cluster.id
  task_definition                   = aws_ecs_task_definition.ugajin_task_definition.arn
  desired_count                     = 2
  launch_type                       = "EC2"
  health_check_grace_period_seconds = 60

  load_balancer {
    target_group_arn = aws_lb_target_group.ugajin_lb_target_group.arn
    container_name   = "nginx"
    container_port   = 80
  }
}