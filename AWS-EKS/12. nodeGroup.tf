resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.K8-cluster.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodeCreationRole.arn
  version         = "1.20.7"
  # Kubernetes version on worker nodes, if not defined master nodes kubernetes version will be taken.

  # adding only private subnets here because we created public subnets for the load balancers 
  # and private subnets for the worker/slave nodes.
  subnet_ids = [
    aws_subnet.first-private-subnet.id,
    aws_subnet.second-private-subnet.id
  ]

  capacity_type = "ON_DEMAND"
  # on demand type nodes, or spot instance type nodes etc

  instance_types = ["t3.small"]
  # instance specifications

  ami_type = "AL2_x86_64"
  # aws machine image
  # possible ami_types: https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html 

  disk_size = 20
  # disk size in GiB
  # 0.93 GiB = 1 GB

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  # add node taints if you want
  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }


  depends_on = [
    aws_iam_role_policy_attachment.nodesAmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodesAmazonEKSCNIPolicy,
    aws_iam_role_policy_attachment.nodesContainerRegistryPolicy,
  ]

}
