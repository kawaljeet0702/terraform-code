#general
region = "us-east-1"
#environment has to be either "dev", "stage" or "prod" 
environment                 = "dev"

#notebook instance
create_notebook_instance= true
sagemaker_instance_name = "testname"
sagemaker_instance_type = "ml.t2.medium"

#Whether root access is Enabled or Disabled for users of the notebook instance. 
#The default value is Enabled.
root_access             = "Enabled"

#default volume_size is 5GB
volume_size             = 5

default_code_repository = ""

#model
create_model            = false
model_name              = "my-model"
#mode can be set as "SingleModel" or "MultiModel"
primary_container = [
        {
          image          = "xxx.dkr.ecr.us-west-2.amazonaws.com/kmeans:1"
          mode           = "SingleModel"
          model_data_url = "s3://xxx/sagemaker/output/prop-train2019-04-11-20-27-04/output/model.tar.gz"
        },
]

#endpoint configuration
create_endpoint_configuration = false
ec_name                       = "my-endpoint-config"
variant_name                  = "variant-1"
#if create_model is set to false, then please provide name of an existing model
ec_model_name                 = "testmodelname"
initial_instance_count        = 1
initial_variant_weight        = 1
ec_instance_type              = "ml.t2.medium"

#endpoint
create_endpoint               = false
endpoint_name                 = "my-endpoint"
#if create_endpoint_configuration is set to false, then please provide name of an existing endpoint configuration
endpoint_config_name          = ""


create_iam_role         = true
iam_role_name           = "sagemaker-role-test-name-123"
policy_name             = "sagemaker-policy-test-name"
policy_filename         = "policy.json"
assume_role_filename    = "assume-role.json"

#if create_role_arn is set to false, then please provide an existing role arn
role_arn                = ""

tags={
tags_project                ="project"
tags_department             ="dept"
tags_department_data_owner  ="owner"
}