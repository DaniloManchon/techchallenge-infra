# VPC
resource "aws_vpc" "techchallenge_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "techchallenge_vpc"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Public Subnet - 1
resource "aws_subnet" "techchallenge_public_subnet_1" {
  vpc_id            = aws_vpc.techchallenge_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zones[0]

  # map_public_ip_on_launch = true # Prevent errors due to destroy process

  tags = {
    Name = "techchallenge_public_subnet_1"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Public Subnet - 2
resource "aws_subnet" "techchallenge_public_subnet_2" {
  vpc_id            = aws_vpc.techchallenge_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "techchallenge_public_subnet_2"
  }
}

# Private Subnet - 1
resource "aws_subnet" "techchallenge_private_subnet_1" {
  vpc_id            = aws_vpc.techchallenge_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "techchallenge_private_subnet_1"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Private Subnet - 2
resource "aws_subnet" "techchallenge_private_subnet_2" {
  vpc_id            = aws_vpc.techchallenge_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "techchallenge_private_subnet_2"
  }

  lifecycle {
    prevent_destroy = false
  }
}

# Internet Gateway
resource "aws_internet_gateway" "techchallenge_igw" {
  vpc_id = aws_vpc.techchallenge_vpc.id

  tags = {
    Name = "techchallenge_igw"
  }
}

# Public route table
resource "aws_route_table" "techchallenge_public_rt" {
  vpc_id = aws_vpc.techchallenge_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.techchallenge_igw.id
  }

  tags = {
    Name = "techchallenge_public_rt"
  }
}

# Public route table association - 1
resource "aws_route_table_association" "techchallenge_public_rt_association_1" {
  subnet_id      = aws_subnet.techchallenge_public_subnet_1.id
  route_table_id = aws_route_table.techchallenge_public_rt.id
}

# Public route table association - 2
resource "aws_route_table_association" "techchallenge_public_rt_association_2" {
  subnet_id      = aws_subnet.techchallenge_public_subnet_2.id
  route_table_id = aws_route_table.techchallenge_public_rt.id
}

# Private route table
resource "aws_route_table" "techchallenge_private_rt" {
  vpc_id = aws_vpc.techchallenge_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.techchallenge_nat_gw.id
  }

  tags = {
    Name = "techchallenge_private_rt"
  }
}

# Private route table association - 1
resource "aws_route_table_association" "techchallenge_private_rt_association_1" {
  subnet_id      = aws_subnet.techchallenge_private_subnet_1.id
  route_table_id = aws_route_table.techchallenge_private_rt.id
}

# Private route table association - 2
resource "aws_route_table_association" "techchallenge_private_rt_association_2" {
  subnet_id      = aws_subnet.techchallenge_private_subnet_2.id
  route_table_id = aws_route_table.techchallenge_private_rt.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "techchallenge_nat_eip" {
  domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "techchallenge_nat_gw" {
  allocation_id = aws_eip.techchallenge_nat_eip.id
  subnet_id     = aws_subnet.techchallenge_public_subnet_1.id

  tags = {
    Name = "techchallenge_nat_gw"
  }
}