resource "aws_autoscaling_group" "for_ecs" {
  name                = "ugajin-test"
  min_size            = 1
  max_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = module.vpc.private_subnets
  target_group_arns   = [aws_lb_target_group.ugajin_lb_target_group.arn]

  launch_template {
    id      = aws_launch_template.for_ecs.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}