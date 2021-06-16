variable "target_group_arn" {
  type        = list(string)
  description = "The arn of the target group"
  }

variable "lc_name" {
  type        = string
  description = "The name of launch configuration"
}

variable "instance_type" {
  type        = string
  description = "The name of instance_type"
  default = "t2.micro"
}

variable "iam_instance_profile" {
  type        = string
  description = "The name of IAM iam_instance profile"
}

variable "key_name" {
  type        = string
  description = "The name of EC2 Key pair"
  }


variable "is_public_ip" {
  type        = string
  description = "associate public ip or not"
  default = "true"
}

variable "cluster_name" {
  type = string
  description = "name of the cluster"
}

variable "asg_name" {
  type        = string
  description = "The name of auto scaling name"
  }

variable "health_check_type" {
  type        = string
  description = "type of health check, EC2 or ELB"
}

variable "vpc_id" {
  type        = string
  description = "vpc id value"
  }

variable "vpc_zone_identifier" {
  type = list(string)
  description = "list of public subnets"
}
