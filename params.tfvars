eks_vpc = {
  name               = "eks-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  tags = {
    "Environment" = "eks"
  }
  eks_subnet_tags = {
    public = {
      "eks-public-subnet-us-east-1a" = "public"
      "eks-public-subnet-us-east-1b" = "public"
      "eks-public-subnet-us-east-1c" = "public"
    }
    private = {
      "eks-private-subnet-us-east-1a" = "private"
      "eks-private-subnet-us-east-1b" = "private"
      "eks-private-subnet-us-east-1c" = "private"
    }
  }
}

db_vpc = {
  name               = "db-vpc"
  cidr               = "10.1.0.0/16"
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets     = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnets    = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
  tags = {
    Environment = "db"
  }
  db_subnet_tags = {
    public = {
      "db-public-subnet-us-east-1a" = "public"
      "db-public-subnet-us-east-1b" = "public"
      "db-public-subnet-us-east-1c" = "public"
    }
    private = {
      "db-private-subnet-us-east-1a" = "private"
      "db-private-subnet-us-east-1b" = "private"
      "db-private-subnet-us-east-1c" = "private"
    }
  }
}

peering_name = "eks-to-db-peering"