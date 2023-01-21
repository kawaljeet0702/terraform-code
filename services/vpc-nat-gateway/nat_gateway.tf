# Setup Elastic IP for NAT gateway. 
resource "aws_eip" "nat" {
    vpc= true
    tags = {
    Name                      = var.tags_eip_name
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = lower(var.tags_department_data_owner)
    }
}
# Setup NAT GW with above EIP. 
resource "aws_nat_gateway" "all" {
    allocation_id                       = aws_eip.nat.id
    subnet_id                           = var.subnet_id

    tags = {
    Name                      = var.tags_name
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = lower(var.tags_department_data_owner)
    }
 }
