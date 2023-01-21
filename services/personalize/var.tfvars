#general
region             = "us-east-1"
delete             = false
#personalize
creator-request-id = "tf-created"
direction          =  "INBOUND"
subnet-ids         =  ["subnet-sdfdasf","subnet-vcvzv"]
security-groups    =  ["sg-2432rsdvsdf"]
ip_addresses       =  ["172.31.27.145", "172.31.88.104"]
schemaname         =  "MovieRatingSchema"
schemafilename     =  "MovieRatingSchema.json"
aws-profile        =  "default"
tags               =  "Key=Environment,Value=development"