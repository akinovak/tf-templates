module "base" {
  source = "../modules/base"

  aws_region = "us-west-2"
  env        = "prod"
}
