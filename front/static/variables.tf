variable "aws_region" {
  type        = string
  description = "The AWS region to put the bucket into"
}

variable "cloudflare_email" {
  type        = string
  description = "email for cloudflare"
}

variable "cloudflare_key" {
  type        = string
  description = "key for cloudflare"
}

variable "site_domain" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "subdomain" {
  type = string
  description = "subdomain which will be used for front"
}