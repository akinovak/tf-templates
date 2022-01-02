terraform {
  backend "s3" {
    bucket         = "prod-tf-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "prod-tf-state-locks"
  }
}
