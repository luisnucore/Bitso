variable "id" {} #these 2 variables are proovided  with therraform execution
variable "key"{}

provider "aws" {
  region = "us-east-2"
  access_key = "${var.id}"
  secret_key = "${var.key}"
}
