# EKS Cluster
resource "aws_eks_cluster" "techchallenge_cluster" {
  name     = var.cluster_name
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
    Name = "techchallenge_cluster"
  }
}

data "aws_eks_cluster_auth" "techchallenge_cluster_auth" {
  name = aws_eks_cluster.techchallenge_cluster.name
}

# EKS Node Group
resource "aws_eks_node_group" "techchallenge_node_group" {
  cluster_name    = aws_eks_cluster.techchallenge_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_eks_cluster.techchallenge_cluster.role_arn
  subnet_ids      = [aws_subnet.techchallenge_private_subnet_1.id, aws_subnet.techchallenge_private_subnet_2.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  lifecycle {
    prevent_destroy = false
  }

  instance_types = [var.instance_type]
  #   disk_size      = 20

  # remote_access {
  #   ec2_ssh_key = var.ssh_key_name
  #   # source_security_group_ids = [aws_security_group.techchallenge_sg.id]
  # }

  ami_type = var.ami_type

  depends_on = [aws_eks_cluster.techchallenge_cluster]

  labels = {}

  tags = {
    Name = "techchallenge_node_group"
  }
}
