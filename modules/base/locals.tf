locals {
  base_namespace = "project-${var.env}"
  default_tags = {
    Terraform = true
    ENV = var.env
  }
}
