resource "aws_eks_cluster" "eks_clusterayy" {
  name     = "eks_clusterayy"
  role_arn = data.aws_iam_role.eks_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.public[0].id,
      aws_subnet.public[1].id,
      aws_subnet.public[2].id,
    ]
  }
  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  depends_on                = [aws_subnet.public[0], aws_subnet.public[1], aws_subnet.public[2], aws_nat_gateway.nat-ayy-gateway]
}

# Déclaration du groupe de nœuds EKS
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_clusterayy.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.NodeGroupRole_5.arn
  instance_types = [var.instance_type]

  subnet_ids = [
    aws_subnet.public[0].id,
    aws_subnet.public[1].id,
    aws_subnet.public[2].id,
  ]

  scaling_config {
    desired_size = 3
    max_size     = 250
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [aws_eks_cluster.eks_clusterayy,
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  aws_eks_cluster.eks_clusterayy, aws_subnet.public[0], aws_subnet.public[1], aws_subnet.public[2]]
}


resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.NodeGroupRole_5.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.NodeGroupRole_5.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.NodeGroupRole_5.name
}
