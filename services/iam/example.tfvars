#general
region      = "us-east-1"
#environment has to be either "dev", "stage" or "prod" 
environment = "dev"

create_iam_policy  = false
#if above is set to true, then please provide an iam policy name
iam_policy_name    = "test-policy"
policy_description = "A test policy"
policy_filename    = "policy.json"


create_role = false
#if above is set to true, then please provide an iam role name
role_name            = "test-role"
role_description     = "A test role"
assume_role_filename = "assume-role.json"

#set below to true if you want to attach newly created policy to role
attach_iam_policy_to_role = false
#if above is set to true, provide a name for atatchment. This is required only by terraform for attachment resource
role_attachment_name   = "test-attachment-policy"
#if create_role is set to false and you want to attach the policy to an existing role, then please provide existing role name
existing_role_names = "role-1"

##mutiple existing policy attachements to role
#set below to true if you want to attach newly created policy to role
attach_multiple_iam_policy_to_role = true
#if above is set to true, provide a name for atatchment. This is required only by terraform for attachment resource
role_attachment_name_for_mutiple_policy_attachment   = "role-1-"
#if create_role is set to false and you want to attach the policy to an existing role, then please provide existing role name
existing_role_names_for_mutiple_policy_attachment = "role-1"
#provide policy arn if you want to attach an existing policy
exisiting_policy_arn_for_role = ["arn:aws:iam::xxx:policy/test-2","arn:aws:iam::xxx:policy/test-1"]

create_iam_instance_profile = true
iam_instance_profile_name = "test-role"
#if create_role is set to true, you do not need to provide an existing role arn below
existing_iam_instance_profile_role = "role:arn"


create_iam_user = false
#if above is set to true, then please provide an iam username
iam_user_name   = "test-user"

#set below to true if you want to attach policy to user
attach_iam_policy_to_user = false
#if above is set to true, provide a name for atatchment. This is required only by terraform for attachment resource
user_attachment_name   = "test-attachment-user"
#if create_iam_user is set to false and you want to attach the policy to an existing user, then please provide existing user name
existing_user_names = "user-1"

##mutiple existing policy attachements to user
#set below to true if you want to attach newly created policy to user
attach_multiple_iam_policy_to_user = true
#if above is set to true, provide a name for atatchment. This is required only by terraform for attachment resource
user_attachment_name_for_mutiple_policy_attachment   = "user-1-"
#if create_iam_user is set to false and you want to attach the policy to an existing user, then please provide existing user name
existing_user_names_for_mutiple_policy_attachment = "user-1"
#provide policy arn if you want to attach an existing policy
exisiting_policy_arn_for_user = ["arn:aws:iam::xxx:policy/test-2","arn:aws:iam::xxx:policy/test-1"]


create_group = false
#if above is set to true, then please provide a group name
group_name   = "test-group"

#set below to true if you want to attach policy to group
attach_iam_policy_to_group = false
#if above is set to true, provide a name for atatchment. This is required only by terraform for attachment resource
group_attachment_name   = "test-attachment-group"
#if create_group is set to false and you want to attach the policy to an existing group, then please provide existing group name
existing_group_names = "group-1"

##mutiple existing policy attachements to group
#set below to true if you want to attach newly created policy to group
attach_multiple_iam_policy_to_group = true
#if above is set to true, provide a name for atatchment. This is required only by terraform for attachment resource
group_attachment_name_for_mutiple_policy_attachment   = "group-1-"
#if create_iam_user is set to false and you want to attach the policy to an existing user, then please provide existing user name
existing_group_names_for_mutiple_policy_attachment = "group-1"
#provide policy arn if you want to attach an existing policy
exisiting_policy_arn_for_group = ["arn:aws:iam::xxx:policy/wav-test-2","arn:aws:iam::xxx:policy/wav-test-1"]
