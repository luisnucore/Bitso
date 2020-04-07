resource "aws_instance" "BitsoEC2" {
  ami           = "ami-0d1cd67c26f5fca19"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.BitsoPublicSubnet.id}"
  vpc_security_group_ids = ["${aws_security_group.BitsoSG.id}"]
  key_name = "terrraform-oregon"
  user_data = <<-EOF
              #!/bin/bash
              echo "<h1>Bitso Challenge || Luis Rios || Cheers! :)" > index.html
              nohup busybox httpd -f -p 8080 &
              DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=9c69c53d75900006ea86a2870429b15c bash -c " $(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
	      EOF
        tags = {
          Name = "BitsoEC2"
        }
}

resource "aws_db_instance" "BitsoRDS" {

  allocated_storage    = 20
  identifier           = "bitsords"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "Bitso"
  password             = "BitsoRDS"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  db_subnet_group_name   = "${aws_db_subnet_group.RDSSubnetGroup.id}"
  vpc_security_group_ids = ["${aws_security_group.BitsoRDSSG.id}"]
  tags = {
    Name = "BitsoRDS"
  }
}
