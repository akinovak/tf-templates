variable "env" {
  type        = string
  description = "Environment name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "az_count" {
  type        = map(number)
  description = "Number of availability zones"
  default = {
    dev  = 3
    prod = 3
  }
}

variable "redis_endpoint" {
  type        = string
  description = "Endpoint for redis"
}

variable "redis_port" {
  type        = number
  description = "port for redis"
  default     = 6379
}
