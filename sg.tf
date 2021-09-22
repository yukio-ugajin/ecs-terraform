resource "aws_security_group" "ecs_sg" {
  name   = "ugajin-ecs-sg"
  vpc_id = module.vpc.vpc_id

  tags = {
    name = "ugajin-test"
  }
}

resource "aws_security_group_rule" "ecs_sg_inbound_rule_for_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}

# resource "aws_security_group_rule" "ecs_sg_inbound_rule_for_ssh" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.ecs_sg.id
# }

# Terraformではアウトバウンドのルールも明記する必要がある。マネコン上だと自動生成される。
resource "aws_security_group_rule" "ecs_sg_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 65536
  protocol          = "-1" # TCP/UDP両方の指定
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_sg.id
}