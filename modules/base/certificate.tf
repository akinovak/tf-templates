# Requires manually adding cert to DNS records

data "aws_acm_certificate" "api" {
  domain   = "your-domain-certificate"
  statuses = ["ISSUED"]
}
