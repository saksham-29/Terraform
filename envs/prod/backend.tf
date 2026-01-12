terraform {
  backend "s3" {
    bucket         = "saksham-buckt-s3 "
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
