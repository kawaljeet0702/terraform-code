resource "aws_subnet" "all" {
    vpc_id                              = var.vpc_id
    cidr_block                          = var.subnet_cidr
    availability_zone                   = var.subnet_az_name

    tags = {
    Name                      = var.subnet_name
    environment               = lower(var.tags_environment)
    Project                   = upper(var.tags_project)
    Department                = var.tags_department
    "Department Data Owner"   = lower(var.tags_department_data_owner)
    }
}

resource "aws_route_table_association" "all" {
  subnet_id      = aws_subnet.all.id
  route_table_id = var.route_table_id
}