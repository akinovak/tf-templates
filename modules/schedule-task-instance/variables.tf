variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "namespace" {
  type        = string
  description = "Base namespace"
}

variable "tags" {
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

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs of VPC private subnets"
}
variable "mongo_uri" {
  type        = map(string)
}