resource "aws_iam_user" "user" {
  count = var.create_iam_user ? 1 : 0
  name  = var.iam_user_name
}

resource "aws_iam_group" "group" {
  count = var.create_group ? 1 : 0
  name  = var.group_name
}

resource "aws_iam_role" "role" {
  count              = var.create_role ? 1 : 0
  name               = var.role_name
  description        = var.role_description
  #assume_role_policy = file("policies/${var.assume_role_filename}")
  assume_role_policy = file("../../../variables/${var.environment}/services/iam/policies/${var.assume_role_filename}")
}

resource "aws_iam_policy" "policy" {
  count       = var.create_iam_policy ? 1 : 0
  name        = var.iam_policy_name
  description = var.policy_description
  #policy = file("policies/${var.policy_filename}")
  policy = file("../../../variables/${var.environment}/services/iam/policies/${var.policy_filename}")
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  count = var.create_iam_instance_profile ? 1 : 0
  name  = var.iam_instance_profile_name
  role  = var.create_role ? aws_iam_role.role[0].id : var.existing_iam_instance_profile_role
}

resource "aws_iam_user_policy_attachment" "user-attach" {
  count      = var.attach_iam_policy_to_user ? 1 : 0
  #name      = var.user_attachment_name
  user       = var.create_iam_user ? aws_iam_user.user[0].name : var.existing_user_names
  policy_arn = aws_iam_policy.policy[0].arn
}

resource "aws_iam_user_policy_attachment" "user-multiple-attach" {
  count      = var.attach_multiple_iam_policy_to_user ? length(var.exisiting_policy_arn_for_user) : 0
  #name      = "${var.user_attachment_name_for_mutiple_policy_attachment}${count.index}"
  user       = var.create_iam_user ? aws_iam_user.user[0].name : var.existing_user_names_for_mutiple_policy_attachment
  policy_arn = var.exisiting_policy_arn_for_user[count.index]
}

/*
resource "aws_iam_policy_attachment" "user-multiple-attach" {
  count      = var.attach_multiple_iam_policy_to_user ? length(var.exisiting_policy_arn_for_user) : 0
  name       = "${var.user_attachment_name_for_mutiple_policy_attachment}${count.index}"
  users      = var.create_iam_user ? [aws_iam_user.user[0].name] : var.existing_user_names_for_mutiple_policy_attachment
  policy_arn = var.exisiting_policy_arn_for_user[count.index]
}*/

resource "aws_iam_role_policy_attachment" "role-attach" {
  count      = var.attach_iam_policy_to_role ? 1 : 0
  #name      = var.role_attachment_name
  role       = var.create_role ? aws_iam_role.role[0].name : var.existing_role_names
  policy_arn = aws_iam_policy.policy[0].arn
}

resource "aws_iam_role_policy_attachment" "role-mutiple-attach" {
  count      = var.attach_multiple_iam_policy_to_role ? length(var.exisiting_policy_arn_for_role) : 0
  #name      = "${var.role_attachment_name_for_mutiple_policy_attachment}${count.index}"
  role       = var.create_role ? aws_iam_role.role[0].name : var.existing_role_names_for_mutiple_policy_attachment
  policy_arn = var.exisiting_policy_arn_for_role[count.index]
}

/*
resource "aws_iam_policy_attachment" "role-attach" {
  count      = var.attach_iam_policy_to_role ? 1 : 0
  name       = var.role_attachment_name
  roles      = var.create_role ? [aws_iam_role.role[0].name] : var.existing_role_names
  policy_arn = aws_iam_policy.policy[0].arn
}

resource "aws_iam_policy_attachment" "role-mutiple-attach" {
  count      = var.attach_multiple_iam_policy_to_role ? length(var.exisiting_policy_arn_for_role) : 0
  name       = "${var.role_attachment_name_for_mutiple_policy_attachment}${count.index}"
  roles      = var.create_role ? [aws_iam_role.role[0].name] : var.existing_role_names_for_mutiple_policy_attachment
  policy_arn = var.exisiting_policy_arn_for_role[count.index]
}*/

resource "aws_iam_group_policy_attachment" "group-attach" {
  count      = var.attach_iam_policy_to_group ? 1 : 0
  #name       = var.group_attachment_name
  group      = var.create_group ? aws_iam_group.group[0].name : var.existing_group_names
  policy_arn = aws_iam_policy.policy[0].arn
}

resource "aws_iam_group_policy_attachment" "group-multiple-attach" {
  count      = var.attach_multiple_iam_policy_to_group ? length(var.exisiting_policy_arn_for_group) : 0
  #name       = "${var.group_attachment_name_for_mutiple_policy_attachment}${count.index}"
  group     = var.create_group ? aws_iam_group.group[0].name : var.existing_group_names_for_mutiple_policy_attachment
  policy_arn = var.exisiting_policy_arn_for_group[count.index]
}

/*
resource "aws_iam_policy_attachment" "group-multiple-attach" {
  count      = var.attach_multiple_iam_policy_to_group ? length(var.exisiting_policy_arn_for_group) : 0
  name       = "${var.group_attachment_name_for_mutiple_policy_attachment}${count.index}"
  groups     = var.create_group ? [aws_iam_group.group[0].name] : var.existing_group_names_for_mutiple_policy_attachment
  policy_arn = var.exisiting_policy_arn_for_group[count.index]
}*/

