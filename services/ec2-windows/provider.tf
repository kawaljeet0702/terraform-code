provider "aws" {
  region = var.region
}

provider "cloudinit" {   
  version = "2.0.0" 
}