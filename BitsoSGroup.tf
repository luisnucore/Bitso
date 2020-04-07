resource "aws_security_group" "BitsoSG" {
  name = "Bitso_Security_Group"
  vpc_id =
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
