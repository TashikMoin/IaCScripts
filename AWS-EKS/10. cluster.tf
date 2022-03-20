resource "aws_eks_cluster" "K8-cluster" {
  name     = "K8-cluster"
  role_arn = aws_iam_role.resource-creation-role.arn
  # desired kubernetes master version

  vpc_config {

    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = [
      aws_subnet.first-private-subnet.id,
      aws_subnet.second-private-subnet.id,
      aws_subnet.first-public-subnet.id,
      aws_subnet.second-public-subnet.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.resource-creation-policy]
}
