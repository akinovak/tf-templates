/*
QUEST: Create a new route table for the private subnets
And make it route non-local traffic through the NAT gateway to the internet
*/

/**
 * Creates a VPC with an Internet Gateway in a public subnet and NAT gateways
 * each private subnet
 */
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = local.base_namespace

  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway  = true
  single_nat_gateway  = false
  reuse_nat_ips       = true
  external_nat_ip_ids = aws_eip.main.*.id

  # All subnets use default network acl

  manage_default_security_group = true
  default_security_group_ingress = []
  default_security_group_egress = [{
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "0.0.0.0/0"
  }]

  enable_flow_log = false

  tags = local.default_tags
}

resource "aws_eip" "main" {
  count = lookup(var.az_count, var.env)

  vpc = true

  tags = local.default_tags
}
