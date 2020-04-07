resource "aws_instance" "BitsoEC2" {
  ami           = "ami-0d1cd67c26f5fca19"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.BitsoPublicSubnet.id}"
  vpc_security_group_ids = ["${aws_security_group.BitsoSG.id}"]
  user_data = <<-EOF
              #!/bin/bash
              echo "Bitso Challenge || Luis Rios" > index.html
              nohup busybox httpd -f -p 8080 &
              DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=9c69c53d75900006ea86a2870429b15c bash -c " $(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
	      EOF

}
