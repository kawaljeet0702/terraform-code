#General
region="us-east-1"
keyname="keyname"
#environment has to be either "dev", "stage" or "prod" 
environment                 = "dev"

#Tags
tags_name="name"
tags_environment="dev"
tags_project="project"
tags_department="dept"
tags_department_data_owner="owner"
tags_fqdn=".net"
tags_app_name="app name"

#EC2
serverinfo= {
count=1
ebs_optimized="true"
root_volume_name="OS"
root_volume_drive="/"
root_volume_type="gp2"
root_volume_size="100"
extra_volumes=2
extra_volume_types="gp2,gp2"
extra_volume_sizes="100,200"
device_names="xvdf,xvdg"
tenancy="default"
cluster_name=""
ami="ami-034234"
size="m5.xlarge"
kms_key_id="arn:aws:kms:us-east-1:xxx:key/xxx"
#
startindex=900
}

eni_id="eni-343223fdf"

#windows_script file
windows_script="dev.tpl"

#tableau installer files
s3_bucket_for_tableau="s3://xxx/tableau/"
destination_folder_name="TableauFiles"

#AD
domain=".net"

#AES_KEY_FILE_$environment.key and Get-AutomationUser-$environment.ps1 location
ad_file_location="s3://xxx/windows/"