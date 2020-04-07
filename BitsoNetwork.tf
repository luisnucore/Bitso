resource "aws_vpc" "BitsoVPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

    tags = {
      Name = "BitsoVPC"
    }

}


resource "aws_subnet" "BitsoPublicSubnet" {
    vpc_id = "${aws_vpc.BitsoVPC.id}"
    cidr_block = "10.0.10.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2a"
    tags = {
        Name = "App subnet"
      }

}

resource "aws_subnet" "BitsoRDSSubnet" {
    vpc_id = "${aws_vpc.BitsoVPC.id}"
    cidr_block = "10.0.9.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-west-2d"
    tags = {
        Name = "RDS subnet"
      }
}

resource "aws_db_subnet_group" "RDSSubnetGroup" {
  name       = "rdssubnetgroup"
  subnet_ids = ["${aws_subnet.BitsoRDSSubnet.id}", "${aws_subnet.BitsoPublicSubnet.id}"]

  tags = {
    Name = "RDSSubnetGroup"
  }
}

resource "aws_internet_gateway" "BitsoIGW" {
    vpc_id = "${aws_vpc.BitsoVPC.id}"
    tags = {
      Name = "BitsoIGW"
    }
}

resource "aws_route_table" "BitsoRouteTable" {
    vpc_id = "${aws_vpc.BitsoVPC.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.BitsoIGW.id}"
    }
    tags = {
      Name = "BitsoRouteTable"
    }

}

resource "aws_route_table_association" "Subnet-RT-Association"{
    subnet_id = "${aws_subnet.BitsoPublicSubnet.id}"
    route_table_id = "${aws_route_table.BitsoRouteTable.id}"
}

resource "aws_route_table_association" "Subnet-RT-AssocRDS"{
    subnet_id = "${aws_subnet.BitsoRDSSubnet.id}"
    route_table_id = "${aws_route_table.BitsoRouteTable.id}"
}
