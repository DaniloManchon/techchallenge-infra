# EKS Cluster
resource "aws_eks_cluster" "cluster" {
  name     = "${var.cluster_name}-cluster"
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids = [
      aws_subnet.public_subnet_1.id,
      aws_subnet.public_subnet_2.id,
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id
    ]
  }

  tags = {
    Name = "${var.cluster_name}-cluster"
  }
}
