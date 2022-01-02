module "base" {
  source = "../modules/base"

  aws_region = "us-east-1"
  env        = "dev"
}
