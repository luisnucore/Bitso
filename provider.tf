variable "id" {} #this variable is proovided  with therraform execution
variable "key"{}
variable "sshkey"{
}

provider "aws" {
  region = "us-east-2"
  access_key = "${var.id}"
  secret_key = "${var.key}"
}
