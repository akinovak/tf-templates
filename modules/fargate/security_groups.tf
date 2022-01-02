module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "${local.namespace}-alb"
  description = "All access to http/s"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
  egress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "API port for external alb"
      source_security_group_id = module.api_security_group.this_security_group_id
    },
    {
      from_port                = local.api_port
      to_port                  = local.api_port
      protocol                 = "tcp"
      description              = "API port for healthcheck"
      source_security_group_id = module.api_security_group.this_security_group_id
    }
  ]
}



module "api_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "${local.namespace}-api"
  description = "VPC access to API ports"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = local.api_port
      to_port     = local.api_port
      protocol    = "tcp"
      description = "API port"
      cidr_blocks = "${var.vpc_cidr_block}"
    },
  ]

  egress_rules       = ["all-all"]
}
