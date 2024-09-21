# Internet Gateway
resource "aws_internet_gateway" "techchallenge_igw" {
  vpc_id = aws_vpc.techchallenge_vpc.id

  tags = {
    Name = "${var.cluster_name}-igw"
  }
}