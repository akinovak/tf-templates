variable "aws_region" {
  type        = string
  description = "The AWS region to put the bucket into"
  default     = "us-east-1"
}

variable "cloudflare_email" {
  type        = string
  description = "email for cloudflare"
}

variable "cloudflare_key" {
  type        = string
  description = "key for cloudflare"
}
