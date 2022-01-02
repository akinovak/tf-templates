output "api_url" {
  value = "http://${local.domain_name}"
}

output "lb_dns" {
  value          = module.alb.this_lb_dns_name
  description    = "dns A record of lb associated with api"
}
