resource "aws_iam_role" "nodeCreationRole" {
  name = "nodeCreationRole"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "nodesAmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodeCreationRole.name
}
# this policy will allow to describe the instances (kubectl get nodes -o wide)

resource "aws_iam_role_policy_attachment" "nodesAmazonEKSCNIPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodeCreationRole.name
}
# this policy will allow us to assign ip addresses, tags etc to the nodes.

resource "aws_iam_role_policy_attachment" "nodesContainerRegistryPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodeCreationRole.name
}
# this policy allows to download our private images from the ECR repository. 
# Elastic Container Registry (ECR) --> container image service at AWS
