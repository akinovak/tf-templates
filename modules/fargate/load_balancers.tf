module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "${local.namespace}-alb"

  load_balancer_type = "application"

  vpc_id          = var.vpc_id
  subnets         = var.public_subnet_ids
  security_groups = [module.alb_security_group.this_security_group_id]
  idle_timeout    = 3600

  internal = true

  target_groups = [
    {
      name_prefix      = "api-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "ip"
      health_check = {
        interval            = 30
        path                = "/status"
        port                = local.api_port
        matcher             = "200"
        healthy_threshold   = 2
        unhealthy_threshold = 3
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = local.default_tags
}
