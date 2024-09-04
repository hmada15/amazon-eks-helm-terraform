resource "aws_iam_role" "eks" {
  name = "${var.eks_name}-eks-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_eks_cluster" "eks" {
  name                      = var.eks_name
  role_arn                  = aws_iam_role.eks.arn
  enabled_cluster_log_types = ["api", "audit"]

  vpc_config {
    subnet_ids = [
      var.subnet_zone1_id,
      var.subnet_zone2_id
    ]
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  tags = var.terraform_tags

  depends_on = [aws_iam_role_policy_attachment.eks]
}
