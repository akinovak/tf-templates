provider "aws" {
  region = var.aws_region
}

module "front" {
  source           = "./static"
  aws_region       = "us-east-1"
  cloudflare_email = var.cloudflare_email
  cloudflare_key   = var.cloudflare_key
  site_domain      = "domain"
  subdomain        = "subdomain"
}