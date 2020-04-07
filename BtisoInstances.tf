resource "aws_instance" "BitsoEC2" {
  ami           = "ami-0d1cd67c26f5fca19"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.BitsoPublicSubnet.id}"
  vpc_security_group_ids = ["${aws_security_group.BitsoSG.id}"]
  key_name = "terrraform-oregon"
  user_data = <<-EOF
              #!/bin/bash
              echo "Bitso Challenge || Luis Rios" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  connection {
                  host          = "${aws_instance.BitsoEC2.public_ip}"
                  type          = "ssh"
                  user          = "ec2-user"
                  private_key   = "${var.pvt_key}"
                  timeout       = "1m"
                  agent         = false
              }
  provisioner "remote-exec" {
                  inline = [ DD_API_KEY=<user_api_key> bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)",

                  ]

}
