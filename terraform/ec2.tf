data "aws_key_pair" "mykeypair" {
  key_name = "sharks-key"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = data.aws_key_pair.mykeypair.key_name

  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  subnet_id = element(data.aws_subnets.default.ids, 0)

  tags = {
    Name = "Test Ec2"
  }
}

resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "Allow SSH and HTTP"

  tags = {
    Name = "Test EC2 SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2-allow-ssh" {
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ec2-allow-http" {
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ec2-allow-https" {
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "ec2-allow-http-test" {
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8443
  to_port           = 8443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ec2-allow-all-traffic" {
  security_group_id = aws_security_group.ec2-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}




