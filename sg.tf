resource "aws_security_group" "ec2_sg" {
  name   = "ugajin-ec2-test"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "ugajin-test"
  }
}

resource "aws_security_group_rule" "ec2_sg_rule_for_inbound1" {
  type              = "ingress"
  from_port         = 49153
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "ec2_sg_rule_for_inbound2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
}

# Terraformではアウトバウンドのルールも明記する必要がある。マネコン上だと自動生成される。
resource "aws_security_group_rule" "ec2_sg_rule_for_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65536
  protocol          = "-1" # TCP/UDP両方の指定
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group" "lb_sg" {
  name   = "ugajin-test"
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "ugajin-test"
  }
}

resource "aws_security_group_rule" "lb_sg_rule_for_inbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}

resource "aws_security_group_rule" "lb_sg_rule_for_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 65536
  protocol          = "-1" # TCP/UDP両方の指定
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}