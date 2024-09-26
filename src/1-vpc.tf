# VPC
resource "aws_vpc" "techchallenge_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
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

data "aws_lb" "techchallenge_ingress_lb" {
  tags = {
    "kubernetes.io/service-name" = "ingress-nginx/ingress-nginx-controller"
  }
  depends_on = [time_sleep.wait_nlb_creation]
}

#VPC Link
resource "aws_api_gateway_vpc_link" "techchallenge_vpc_link" {
  name        = "${var.cluster_name}-vpc-link"
  target_arns = [data.aws_lb.techchallenge_ingress_lb.arn]
}

#VPC Endpoint
resource "aws_vpc_endpoint" "techchallenge_vpc_endpoint" {
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.eks_security_group.id]
  service_name        = "com.amazonaws.${var.aws_region}.execute-api"
  subnet_ids = [
    aws_subnet.techchallenge_private_subnet_1.id,
    aws_subnet.techchallenge_private_subnet_2.id
  ]
  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.techchallenge_vpc.id
}
