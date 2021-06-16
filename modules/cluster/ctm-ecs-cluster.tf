resource "aws_ecs_cluster" "ctm-ecs-cluster" {
  name               = var.cluster_name
  capacity_providers = [aws_ecs_capacity_provider.ecs-cp.name]
  tags = {
    "env"       = var.env_name
    "createdBy" = var.author_name
  }
}

# capacity provider(CP) for ASG for EC2 instacnes, 
# managed scaling is enabled, when creating the CP , ECS manages 
# scale-in & scale-out actions of ASG.
resource "aws_ecs_capacity_provider" "ecs-cp" {
  name = var.capacity_provider_name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.aws_autoscaling_group_arn
   
    managed_termination_protection = var.managed_termination_protection_enabled

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 85
    }
  }
}




resource "aws_ecs_service" "ctm-service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ctm-ecs-cluster.id
  task_definition = var.task_definition_arn
  desired_count   = 2
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
  load_balancer {
    target_group_arn     = var.target_group_arn 
    container_name   = var.container_name
    container_port   = var.container_port    
  }
  # Optional: Allow external changes without Terraform plan difference(for example ASG)
  lifecycle {
    ignore_changes = [desired_count]
  }
  launch_type = "EC2"
 
}

# Streaming instance logs to CloudWatch Logs
resource "aws_cloudwatch_log_group" "ctm-cw-lg" {
  name = var.cw_group_name
  tags = {
    "env"       = var.env_name
    "createdBy" = var.author_name
  }
}
