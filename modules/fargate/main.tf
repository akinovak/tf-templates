provider "aws" {
  region = var.aws_region
}

provider "docker" {
  host = "http://registry.hub.docker.com"
}
