#set a provider
provider "aws" {
  region = "eu-west-1"
}
# create vpc
resource "aws_vpc" "node_vpc" {
  terraform import aws_vpc.node_vpc vpc-02ecab0a45ffcfc39
}
#create a subnet
#resource "aws_subnet" "node_subnet" {
#  vpc_id = "${aws_vpc.node_vpc.id}"
#  cidr_block = "10.0.0.0/24"
#  availability_zone = "eu-west-1a"
#  tags = {
#  Name = var.Name
#  }
#}
#aws security group creation
resource "aws_security_group" "nodejs_app_sg" {
  terraform import aws_security_group.nodejs_app_sg sg-0129857d90ecad1a2
}
#Route table
#resource "aws_route_table" "node_route" {
#vpc_id = aws_vpc.node_vpc.id
#  route {
#    cidr_block = "0.0.0.0/0"
#    gateway_id = aws_internet_gateway.node_gateway.id
#    }
#  tags = {
#  Name = var.Name
#  }
#}
# Route table associations
#resource "aws_route_table_association" "node_assoc" {
#subnet_id = aws_subnet.node_subnet.id
#route_table_id = aws_route_table.node_route.id
#}
# security
#resource "aws_internet_gateway" "node_gateway" {
#vpc_id = aws_vpc.node_vpc.id
#tags = {
#Name = var.Name
#}
#}
#Launch an instance
resource "aws_instance" "node_instance" {
ami          = "ami-067bf2b5ff598f6ba"
#subnet_id = "${aws_subnet.node_subnet.id}"
vpc_security_group_ids = ["${aws_security_group.nodejs_app_sg.id}"]
instance_type = "t2.micro"
associate_public_ip_address = true
#user_data = data.template_file.app_init.rendered
tags = {
  Name = var.Name
}
}
