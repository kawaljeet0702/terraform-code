#General
region="us-east-1"
keyname="terraform-automation"
#environment has to be either "dev", "stage" or "prod" 
environment                 = "dev"

#Tags
tags_name="name"
tags_environment="dev"
tags_project="project"
tags_department="dept"
tags_department_data_owner="owner"
tags_fqdn="dev.aws.net"
tags_app_name="app name"

#EC2
serverinfo= {
count=1
ebs_optimized="true"
root_volume_name="OS"
root_volume_drive="/"
root_volume_type="gp2"
root_volume_size="100"
extra_volumes=1
extra_volume_types="gp2"
extra_volume_sizes="200"
device_names="xvdf"
#extra_volume_drive_names="data,secondata,thirddata"
#extra_volume_drives="/data,/seconddata,/thirddata"
#extra_volume_fs_types="xfs"
tenancy="default"
cluster_name=""
ami= "ami-234324324"
size="m6g.2xlarge"
kms_key_id="arn:aws:kms:us-east-1:xxx:key/xxx"
startindex=200
}

#Cloud_init
cloud_init="test.cfg"

eni_id="eni-2342323fef3"