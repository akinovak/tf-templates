terraform {
  backend "s3" {
    bucket         = "dev-tf-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "dev-tf-state-locks"
  }
}
