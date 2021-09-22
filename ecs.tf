resource "aws_ecs_cluster" "ugajin_cluster" {
  name = "ugajin-cluster"

  # CloudWatch Container Insightsの有効化
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

