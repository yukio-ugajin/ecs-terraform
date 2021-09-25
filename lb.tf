resource "aws_lb" "ugajin_lb" {
  name               = "ugajin-test"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.lb_sg.id]
}

resource "aws_lb_listener" "ugajin_lb_listener" {
  load_balancer_arn = aws_lb.ugajin_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ugajin_lb_target_group.arn
  }
}

resource "aws_lb_target_group" "ugajin_lb_target_group" {
  name     = "ugajin-test"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    interval = 20
    timeout  = 10
    port     = "traffic-port"
  }
}