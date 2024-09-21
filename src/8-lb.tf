resource "aws_lb" "techchallenge_lb" {
  name               = "${var.cluster_name}-lb"
  load_balancer_type = "network"
  subnets = [
    aws_subnet.techchallenge_public_subnet_1.id,
    aws_subnet.techchallenge_public_subnet_2.id
  ]

  enable_cross_zone_load_balancing = true

}
