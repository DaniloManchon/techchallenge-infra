# VPC
resource "aws_vpc" "techchallenge_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.cluster_name}-vpc"
  }

  lifecycle {
    prevent_destroy = false
  }
}

#VPC Security Group
resource "aws_security_group" "eks_security_group" {
  vpc_id = aws_vpc.techchallenge_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-sg"
  }
}

#VPC Link
# resource "aws_api_gateway_vpc_link" "techchallenge_vpc_link" {
#   name        = "${var.cluster_name}-vpc-link"
#   target_arns = [aws_lb.techchallenge_lb.arn]

# }

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "private_subnets_list" {
  for_each = toset(data.aws_subnets.example.ids)
  id       = each.value
}

resource "aws_apigatewayv2_vpc_link" "techchallenge_vpc_link" {
  name               = "${var.cluster_name}-vpc-link"
  security_group_ids = aws_security_group.eks_security_group.id
  subnet_ids = data.aws_subnets.private_subnets_list.ids
  depends_on = [ 
    aws_subnet.techchallenge_private_subnet_1,
    aws_subnet.techchallenge_private_subnet_2
 ]
}