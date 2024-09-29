## EKS Node Group
#resource "aws_eks_node_group" "node_group" {
#  cluster_name    = aws_eks_cluster.cluster.name
#  node_group_name = "${var.cluster_name}-ng"
#  node_role_arn   = aws_eks_cluster.cluster.role_arn
#  subnet_ids = [
#    aws_subnet.private_subnet_1.id,
#    aws_subnet.private_subnet_2.id
#  ]
#
#  scaling_config {
#    desired_size = 2
#    max_size     = 3
#    min_size     = 1
#  }
#
#  lifecycle {
#    prevent_destroy = false
#  }
#
#  instance_types = [var.instance_type]
#  ami_type       = var.ami_type
#
#  depends_on = [aws_eks_cluster.cluster]
#
#  labels = {}
#
#  tags = {
#    Name = "${var.cluster_name}-ng"
#  }
#}
