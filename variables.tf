variable "eks_vpc" {
  type = object({
    name               = string
    cidr               = string
    azs                = list(string)
    public_subnets     = list(string)
    private_subnets    = list(string)
    tags               = map(string)
    eks_subnet_tags    = object({
      public  = map(string)
      private = map(string)
    })
  })
}

variable "db_vpc" {
  type = object({
    name               = string
    cidr               = string
    azs                = list(string)
    public_subnets     = list(string)
    private_subnets    = list(string)
    tags               = map(string)
    db_subnet_tags     = object({
      public  = map(string)
      private = map(string)
    })
  })
}

variable "peering_name" {
  type = string
}
