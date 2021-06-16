# Creating ALB with Target groups , securit groups and listener
resource "aws_lb" "ctm-lb" {
  name               = var.lb_name
  load_balancer_type =  var.load_balancer_type
  internal           =  var.is_internal
  subnets            = var.vpc_public_subnets
  tags = {
    "env"       =  var.envi_name
    "createdBy" =  var.writer_name
  }
  security_groups = [aws_security_group.sg.id]
}

# security groups to make sure the app is properly protected.
# we can create a separate module for Security groups
resource "aws_security_group" "sg" {
  name   = "allow-all-loadbalancer"
  vpc_id = var.lb_vpc_id
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
    "env"       = "production"
    "createdBy" = "mamujahid"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = var.tg_name
  port        = var.lb_port
  protocol    = "HTTP"
  target_type = var.target_type
  vpc_id      = var.lb_vpc_id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "ctm-web-listener" {
  load_balancer_arn = aws_lb.ctm-lb.arn
  port              = var.lb_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}
