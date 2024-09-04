module "vpc" {
  source         = "./modules/vpc"
  env            = var.env
  zone1          = var.zone1
  zone2          = var.zone2
  eks_name       = var.eks_name
  terraform_tags = var.terraform_tags
}

module "eks" {
  source          = "./modules/eks"
  env             = var.env
  subnet_zone1_id = module.vpc.subnet_zone1_id
  subnet_zone2_id = module.vpc.subnet_zone2_id
  eks_name        = var.eks_name
  terraform_tags  = var.terraform_tags
}
