variable "env" {
  type        = string
  description = "Environment name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default = "us-east-1"
}

variable "base_tags" {
  type        = any
  description = "Tags to merge with local defaults"
}

variable "base_namespace" {
  type        = string
  description = "Base namespace"
}
variable "env" {
  type        = string
  description = "env"
}