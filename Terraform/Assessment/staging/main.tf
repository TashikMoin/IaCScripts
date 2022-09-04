module "monese_networking" {
  source                              = "./modules/networking"
  VPC_NAME                            = var.VPC_NAME
  CIDR_BLOCK                          = var.CIDR_BLOCK
  REGION                              = var.REGION
  PRIVATE_SUBNET_A_CIDR_BLOCK         = var.PRIVATE_SUBNET_A_CIDR_BLOCK
  PUBLIC_SUBNET_A_CIDR_BLOCK          = var.PUBLIC_SUBNET_A_CIDR_BLOCK
  PUBLIC_SUBNET_B_CIDR_BLOCK          = var.PUBLIC_SUBNET_B_CIDR_BLOCK
  GATEWAY                             = var.GATEWAY
  ROUTE_TABLE_PUBLIC_SUBNET_A         = var.ROUTE_TABLE_PUBLIC_SUBNET_A
  ROUTE_TABLE_PUBLIC_SUBNET_B         = var.ROUTE_TABLE_PUBLIC_SUBNET_B
  AWS_ALB_NAME                        = var.AWS_ALB_NAME
}


module "monese_storage" {
  source                              = "./modules/storage"
  STATE_BUCKET                        = var.STATE_BUCKET
  DYNAMO_TABLE                        = var.DYNAMO_TABLE
  SOURCE_CODE_BUCKET                  = var.SOURCE_CODE_BUCKET
  DATA_BUCKET                         = var.DATA_BUCKET
}


module "monese_application" {
  source                              = "./modules/application"
  LAMBDA_FUNCTION_NAME                = var.LAMBDA_FUNCTION_NAME
  LAMBDA_RUNTIME                      = var.LAMBDA_RUNTIME
  LAMBDA_HANDLER                      = var.LAMBDA_HANDLER
  LAMBDA_ROLE_NAME                    = var.LAMBDA_ROLE_NAME
  LAMBDA_TARGET_GROUP_NAME            = var.LAMBDA_TARGET_GROUP_NAME

  # Data Data bubbles up from the networking, storage modules and trickles down into the application module.
  VPC_ID                              = module.monese_networking.VPC_ID               # coming from the output of networking module
  PRIVATE_SUBNET_A_ID                 = module.monese_networking.PRIVATE_SUBNET_A_ID  # coming from the output of networking module
  SECURITY_GROUP_ID                   = module.monese_networking.SECURITY_GROUP_ID    # coming from the output of networking module
  ALB_ARN                             = module.monese_networking.ALB_ARN              # coming from the output of networking module
  SOURCE_CODE_BUCKET_ID               = module.monese_storage.SOURCE_CODE_BUCKET_ID   # coming from the output of storage module
}
