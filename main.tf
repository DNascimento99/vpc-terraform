module "eks_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name               = var.eks_vpc.name
  cidr               = var.eks_vpc.cidr
  azs                = var.eks_vpc.azs
  public_subnets     = var.eks_vpc.public_subnets
  private_subnets    = var.eks_vpc.private_subnets
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_support = true
  enable_dns_hostnames = true

  public_subnet_tags  = var.eks_vpc.eks_subnet_tags.public
  private_subnet_tags = var.eks_vpc.eks_subnet_tags.private

  tags = var.eks_vpc.tags
}

module "db_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name               = var.db_vpc.name
  cidr               = var.db_vpc.cidr
  azs                = var.db_vpc.azs
  public_subnets     = var.db_vpc.public_subnets
  private_subnets    = var.db_vpc.private_subnets
  enable_nat_gateway = false
  enable_dns_support = true
  enable_dns_hostnames = true

  public_subnet_tags  = var.db_vpc.db_subnet_tags.public
  private_subnet_tags = var.db_vpc.db_subnet_tags.private

  tags = var.db_vpc.tags
}

resource "aws_vpc_peering_connection" "eks_to_db_peering" {
  vpc_id        = module.eks_vpc.vpc_id
  peer_vpc_id   = module.db_vpc.vpc_id
  auto_accept   = true 
  tags = {
    Name = var.peering_name
  }
}

resource "aws_route" "eks_to_db_route" {
  route_table_id = module.eks_vpc.public_route_table_ids[0]
  destination_cidr_block = var.db_vpc.cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.eks_to_db_peering.id
}

resource "aws_route" "db_to_eks_route" {
  route_table_id = module.db_vpc.public_route_table_ids[0] 
  destination_cidr_block = var.eks_vpc.cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.eks_to_db_peering.id
}
