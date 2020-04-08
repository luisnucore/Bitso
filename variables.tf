variable "id" {} #these 2 variables are proovided  with therraform execution
variable "key"{}

output "instance_ips" {
  value = ["${aws_instance.BitsoEC2.public_ip}"]
}
