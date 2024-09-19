data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.techchallenge_vpc.id]
  }

  tags = {
    Tier = "Public"
  }
}

resource "aws_lb" "techchallenge_lb" {
  name               = "${var.cluster_name}-lb"
  load_balancer_type = "network"
  subnets            = data.aws_subnets.public_subnets.ids

  enable_cross_zone_load_balancing = true
  depends_on = [
    aws_vpc.techchallenge_vpc,
    aws_security_group.eks_security_group,
    aws_subnet.techchallenge_public_subnet_1,
    aws_subnet.techchallenge_public_subnet_2
  ]
}

resource "aws_api_gateway_vpc_link" "techchallenge_vpc_link" {
  name        = "${var.cluster_name}-vpc-link"
  target_arns = [aws_lb.techchallenge_lb.arn]
}