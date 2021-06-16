variable "lb_name" {
  type        = string
  description = "The name of load balancer"
}

variable "load_balancer_type" {
  type        = string
  description = "The name of load balancer type"
  }

variable "is_internal" {
  type        = string
  description = "whether public lb or private lb"
 }

variable "envi_name" {
  type        = string
  description = "The name of environemnt"
 }

variable "writer_name" {
  type        = string
  description = "The name of writer"
 }

variable "tg_name" {
  type        = string
  description = "The name of target group"
  default = ""
}

variable "lb_port" {
  type = string
  description = "port of load balancer"
}

variable "target_type" {
  type = string
  description = "type of the target"
  default = "instance"
}

variable "lb_vpc_id" {
  type = string
  description = "id of vpc"
}

variable "vpc_public_subnets" {
  type = list(string)
  description = "public subnets of vpc"
}
