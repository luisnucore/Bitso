variable "id" {} #these 2 variables are proovided  with therraform execution
variable "key"{}
variable "pvt_tkey" {}

provider "aws" {
  region = "us-west-2"
  access_key = "${var.id}"
  secret_key = "${var.key}"
}
