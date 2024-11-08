variable "region" {
  description = "Région AWS à utiliser"
  type        = string
}
variable "instance_type" {
  description = "type instance EC2"
  type        = string
}

variable "version_vpc_cni" {
  type    = string
  default = "v1.18.5-eksbuild.1"
}

variable "version_core_dns" {
  type    = string
  default = "v1.11.3-eksbuild.1"
}

variable "version_kube_proxy" {
  type    = string
  default = "v1.31.0-eksbuild.5"
}

data "aws_iam_role" "eks_role" {
  name = "EKS_Students"
}

resource "aws_iam_role" "NodeGroupRole_5" {
  name = "EKSNodeGroupRole_5-2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com",
            "eks.amazonaws.com",
            "eks-nodegroup.amazonaws.com"
          ]
        }
      },
    ]
  })
}