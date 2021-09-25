data "aws_ssm_parameter" "ecs_optimized_ami_image_id" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "for_ecs" {
  name                   = "ugajin-test"
  image_id               = data.aws_ssm_parameter.ecs_optimized_ami_image_id.value
  instance_type          = "t2.micro"
  key_name               = "ugajin-autoscaling-key"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ugajin-test"
    }
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.for_ecs.arn
  }

  user_data = filebase64("./register_cluster.sh")
}

resource "aws_iam_instance_profile" "for_ecs" {
  name = "ugajin-test"
  role = aws_iam_role.for_ecs_instance.name
}
