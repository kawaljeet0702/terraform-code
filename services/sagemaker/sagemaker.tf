resource "aws_sagemaker_notebook_instance" "notebook_instance" {
  count                    = var.create_notebook_instance ? 1 : 0
  name                     = var.sagemaker_instance_name
  role_arn                 = var.create_iam_role ? aws_iam_role.sagemaker_role[0].arn : var.role_arn
  instance_type            = var.sagemaker_instance_type
  root_access              = var.root_access
  default_code_repository  = var.default_code_repository
  volume_size              = var.volume_size
  tags                     = var.tags
}

resource "aws_sagemaker_model" "model" {
  count              = var.create_model ? 1 : 0
  name               = var.model_name
  execution_role_arn = var.create_iam_role ? aws_iam_role.sagemaker_role[0].arn : var.role_arn

  dynamic "primary_container" {
    for_each = var.primary_container
    content{
    image          = primary_container.value.image
    mode           = primary_container.value.mode
    model_data_url = primary_container.value.model_data_url
    }
  }

  tags                     = var.tags
}

resource "aws_sagemaker_endpoint_configuration" "endpoint_configuration" {
  count = var.create_endpoint_configuration ? 1 : 0
  name  = var.ec_name

  production_variants {
    variant_name           = var.variant_name
    model_name             = var.create_model ? aws_sagemaker_model.model[0].name : var.ec_model_name
    initial_instance_count = var.initial_instance_count
    initial_variant_weight = var.initial_variant_weight
    instance_type          = var.ec_instance_type
  }

  tags                     = var.tags
}

resource "aws_sagemaker_endpoint" "endpoint" {
  count                = var.create_endpoint? 1 : 0
  name                 = var.endpoint_name
  endpoint_config_name = var.create_endpoint_configuration ? aws_sagemaker_endpoint_configuration.endpoint_configuration[0].name : var.endpoint_config_name
  tags                 = var.tags
}

resource "aws_iam_role_policy" "sagemaker_policy" {
  count = var.create_iam_role ? 1 : 0
  name = var.policy_name
  role = aws_iam_role.sagemaker_role[0].id
  policy = file("../../../variables/${var.environment}/services/sagemaker/policies/${var.policy_filename}")
  #policy = file("policies/${var.policy_filename}")
}

resource "aws_iam_role" "sagemaker_role" {
  count = var.create_iam_role ? 1 : 0
  name = var.iam_role_name
  assume_role_policy = file("../../../variables/${var.environment}/services/sagemaker/policies/${var.assume_role_filename}")
  #assume_role_policy = file("policies/${var.assume_role_filename}")
}