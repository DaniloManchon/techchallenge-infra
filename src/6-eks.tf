# EKS Cluster
resource "aws_eks_cluster" "techchallenge_cluster" {
  name     = "${var.cluster_name}-cluster"
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids = [
      aws_subnet.techchallenge_public_subnet_1.id,
      aws_subnet.techchallenge_public_subnet_2.id,
      aws_subnet.techchallenge_private_subnet_1.id,
      aws_subnet.techchallenge_private_subnet_2.id
    ]

    # security_group_ids = [aws_security_group.techchallenge_eks_sg.id]
  }

  tags = {
    Name = "${var.cluster_name}-cluster"
  }
}

data "aws_eks_cluster_auth" "techchallenge_cluster_auth" {
  name = aws_eks_cluster.techchallenge_cluster.name
}
