resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  # refering to vpc resource in vpc.tf file and getting its id once vpc is created.
  # attaching this internet gateway with the newly created vpc for internet(external) communication.
  # terraform will make a dependency graph by itself and then it will provision these resource 
  # using that direct acyclic graph (DAG).

  tags = {
    Name = "main-igw"
  }
}

# reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
