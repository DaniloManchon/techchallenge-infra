# Public route table
resource "aws_route_table" "techchallenge_public_rt" {
  vpc_id = aws_vpc.techchallenge_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.techchallenge_igw.id
  }

  tags = {
    Name = "${var.cluster_name}-public_rt"
  }
}

# Public route table associations
resource "aws_route_table_association" "techchallenge_public_rt_association_1" {
  subnet_id      = aws_subnet.techchallenge_public_subnet_1.id
  route_table_id = aws_route_table.techchallenge_public_rt.id
}

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
    Name = "${var.cluster_name}-private_rt"
  }
}

# Private route table associations
resource "aws_route_table_association" "techchallenge_private_rt_association_1" {
  subnet_id      = aws_subnet.techchallenge_private_subnet_1.id
  route_table_id = aws_route_table.techchallenge_private_rt.id
}

resource "aws_route_table_association" "techchallenge_private_rt_association_2" {
  subnet_id      = aws_subnet.techchallenge_private_subnet_2.id
  route_table_id = aws_route_table.techchallenge_private_rt.id
}
