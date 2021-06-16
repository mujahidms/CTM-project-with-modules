
# In this block, we are pulling ecs-optimized ami.
# note: attributes of this data ami block can be used as variables .
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "self"]
}

# security groups to make sure the app is properly protected.
# we can create a separate module for Security groups
resource "aws_security_group" "aws-ec2-sg" {
  name        = "allow-all-ec2"
  description = "allow all"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "env"       = "development"
    "createdBy" = "mamujahid"
  }
}

resource "aws_launch_configuration" "aws_lc" {
  name          =  var.lc_name
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile        = var.iam_instance_profile 
  key_name                    = var.key_name
  security_groups             = [aws_security_group.aws-ec2-sg.id]
  associate_public_ip_address = var.is_public_ip
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.cluster_name}" >> /etc/ecs/ecs.config
EOF
}

resource "aws_autoscaling_group" "aws_asg" {
  name                      = var.asg_name
  launch_configuration      = aws_launch_configuration.aws_lc.name
  
  # we can pass below attributes  as variables as well
  min_size                  = 3
  max_size                  = 5
  desired_capacity          = 3
  health_check_type         = var.health_check_type
  health_check_grace_period = 300
  vpc_zone_identifier       = var.vpc_zone_identifier
  target_group_arns         = var.target_group_arn
 

  # To enable ECS managed scaling , I need to enable "protect from scale"
  protect_from_scale_in = true
  
  # This lifecycle meta argument ensure that a new replacement object is created first 
  # and earlier object is destroyed after teh replacment is created
  #lifecycle {
   # create_before_destroy = true
  #}
}
