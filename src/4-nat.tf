# NAT Gateway
resource "aws_nat_gateway" "techchallenge_nat_gw" {
  allocation_id = aws_eip.techchallenge_nat_eip.id
  subnet_id     = aws_subnet.techchallenge_public_subnet_1.id

  tags = {
    Name = "${var.cluster_name}-nat_gw"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "techchallenge_nat_eip" {
  domain = "vpc"
}
