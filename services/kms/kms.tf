resource "aws_kms_key" "key" {
  description             = var.key_description
  deletion_window_in_days = var.deletion_window_in_days
  policy                  = var.attach_policy ? (file("../../../variables/${var.environment}/services/kms/policies/${var.policy_filename}")) : ""
  #policy                  = var.attach_policy ? (file("/policies/${var.policy_filename}")) : ""
  is_enabled              = var.is_enabled
  tags                    = var.tags
}

resource "aws_kms_alias" "key_alias" {
  name          = "alias/${var.key_alias_name}"
  target_key_id = aws_kms_key.key.key_id
}