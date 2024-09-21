# Public Subnets
resource "aws_subnet" "techchallenge_public_subnet_1" {
  vpc_id            = aws_vpc.techchallenge_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zones[0]

  # map_public_ip_on_launch = true 
  # Prevent errors due to destroy process

  tags = {
    Name = "${var.cluster_name}-public_subnet_1"
    Tier = "Public"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_subnet" "techchallenge_public_subnet_2" {
  vpc_id            = aws_vpc.techchallenge_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.cluster_name}-public_subnet_2"
    Tier = "Public"
  }
}

# Private Subnets
resource "aws_subnet" "techchallenge_private_subnet_1" {
  vpc_id            = aws_vpc.techchallenge_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "${var.cluster_name}-private_subnet_1"
    Tier = "Private"
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_subnet" "techchallenge_private_subnet_2" {
  vpc_id            = aws_vpc.techchallenge_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "${var.cluster_name}-private_subnet_2"
    Tier = "Private"
  }

  lifecycle {
    prevent_destroy = false
  }
}
