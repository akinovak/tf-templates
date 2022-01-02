/* Given */

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "base_namespace" {
  type        = string
  description = "Base namespace"
}

variable "base_tags" {
  type        = any
  description = "Tags to merge with local defaults"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "ARN of ECS task execution role"
}

variable "ecs_task_execution_role_id" {
  type        = string
  description = "Id of ECS task execution role"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of VPC private subnets"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "IDs of VPC public subnets"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block of VPC"
}

variable "vpc_id" {
  type        = string
  description = "Existing VPC ID"
}

variable "vpc_security_group_id" {
  type        = string
  description = "ID of VPC default security group"
}

/* Specified */


/** vars for tasks based on env **/

variable "node_env" {
  type = map(string)
  default = {
    dev  = "development"
    prod = "production"
  }
}

variable "api_port" {
  type        = number
  description = "api port"
}

variable "api_cpu" {
  type        = string
  description = "api cpu"
}

variable "api_memory" {
  type        = string
  description = "api memory"
}