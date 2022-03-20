# defining a role so that we can assign it to eks and eks can use this role to create 
# aws resources for the cluster requirements automatically.

# firstly, we define a role with its assume policy. An assume policy allows to tell the role that
# who can assume that role.

# secondly, we will create a policy having all the required actions/permissions to make resources
# on aws and then we will associate the defined role with this policy.

resource "aws_iam_role" "resource-creation-role" {
  name = "resource-creation-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "resource-creation-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.resource-creation-role.name
}
