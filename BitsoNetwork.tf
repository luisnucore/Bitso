resource "aws_vpc" "BitsoVPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"

}

resource "aws_internet_gateway" "BitsoIGW" {
    vpc_id = "${aws_vpc.BitsoVPC.id}"

}

resource "aws_subnet" "BitsoPublicSubnet" {
    vpc_id = "${aws_vpc.BitsoVPC.id}"
    cidr_block = "10.0.10.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2"

}

resource "aws_route_table" "BitsoRouteTable" {
    vpc_id = "${aws_vpc.main-vpc.id}"

    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.BitsoIGW.id}"
    }


}

resource "aws_route_table_association" "Subnet-RT-Association"{
    subnet_id = "${aws_subnet.BitsoPublicSubnet.id}"
    route_table_id = "${aws_route_table.BitsoRouteTable.id}"
}
