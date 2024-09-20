resource "aws_lb" "techchallenge_lb" {
  name               = "${var.cluster_name}-lb"
  load_balancer_type = "network"
  subnets = [
    aws_subnet.techchallenge_public_subnet_1.id,
    aws_subnet.techchallenge_public_subnet_2.id
  ]

  enable_cross_zone_load_balancing = true

}

resource "aws_api_gateway_vpc_link" "techchallenge_vpc_link" {
  name        = "${var.cluster_name}-vpc-link"
  target_arns = [aws_lb.techchallenge_lb.arn]
}