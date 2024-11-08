#Ajout de l'addon vpc_cni au cluster eks
resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.eks_clusterayy.name
  addon_name    = "vpc-cni"
  addon_version = var.version_vpc_cni
  tags = {
    Name = "grp5-vpc-cni"
  }
  depends_on = [aws_eks_node_group.eks_node_group]
}

#Ajout de l'addon coredns au cluster eks
resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.eks_clusterayy.name
  addon_name    = "coredns"
  addon_version = var.version_core_dns
  tags = {
    Name = "grp5-coredns"
  }
  depends_on = [aws_eks_node_group.eks_node_group]
}

#Ajout de l'addon kube_proxy au cluster eks
resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.eks_clusterayy.name
  addon_name    = "kube-proxy"
  addon_version = var.version_kube_proxy
  tags = {
    Name = "grp5-kubeproxy"
  }
  depends_on = [aws_eks_node_group.eks_node_group]
}