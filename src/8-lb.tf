# Network LoadBalancer
# resource "aws_lb" "techchallenge_lb" {
#   name               = "${var.cluster_name}-lb"
#   load_balancer_type = "network"
#   subnets = [
#     aws_subnet.public_subnet_1.id,
#     aws_subnet.public_subnet_2.id
#   ]

#   enable_cross_zone_load_balancing = true

# }

resource "time_sleep" "wait_nlb_creation" {
  create_duration = "5m"
  depends_on      = [helm_release.ingress]
}

data "aws_lb" "ingress_lb" {
  tags = {
    "kubernetes.io/service-name" = "ingress-nginx/ingress-nginx-controller"
  }
  depends_on = [time_sleep.wait_nlb_creation]
}
