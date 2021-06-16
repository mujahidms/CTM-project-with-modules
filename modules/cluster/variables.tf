variable "key_name" {
  type        = string
  description = "The name for ssh key, used for aws_launch_configuration"
  default = "CTM_ECS_KEY"
}

variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
  }

variable "env_name" {
  type        = string
  description = "The name of environment"
}
variable "author_name" {
  type        = string
  description = "The name of author"
  
}
variable "capacity_provider_name" {
  type        = string
  description = "The name of ecs capacity provider"
  }
variable "managed_termination_protection_enabled" {
  type        = string
  description = "The name of "
  default = "ENABLED"
}

variable "aws_autoscaling_group_arn" {
  type = string
  description = "arn of autoscaling group arn"
}
variable "service_name"{
    type = string
    description = "cluster service name"
}

variable "target_group_arn" {
  type = string
  description = " arn of TG"
}

variable "container_name" {
  type = string
  description = "name of the container"
}
variable "container_port" {
  type = number
  description = "port of the container"
}

variable "task_definition_arn" {
  type = string
  description = "arn of the task definition"
}

variable "cw_group_name"{
  type = string
  description = " nae of the cloud watch group"
}



