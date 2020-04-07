provider "aws" {
  region = "us-west-2"
  access_key = "${var.id}"
  secret_key = "${var.key}"
}
