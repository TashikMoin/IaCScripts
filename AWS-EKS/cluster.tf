module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets


  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }


  # Nodes launched as part of a managed node group are automatically tagged for auto-discovery 
  # by the Kubernetes cluster autoscaler. Each node group runs across multiple Availability 
  # Zones that you define.

  # With Amazon EKS managed node groups, you don’t need to separately provision or register the 
  # Amazon EC2 instances that provide compute capacity to run your Kubernetes applications. You 
  # can create, automatically update, or terminate nodes for your cluster with a single operation. 
  # Node updates and terminations automatically drain nodes to ensure that your applications stay 
  # available.

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [aws_security_group.first_node_group.id]
      asg_desired_capacity          = 2 # nodes auto scaling desired limit
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
