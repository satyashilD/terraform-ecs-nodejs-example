# terraform-ecs-nodejs-example

# pre-requisites:
- aws cli 
- docker
- terraform

# Flow of execution
- Update terraform.tfvars with correct details according to your test need. SUbnets and region should be passed to these scripts as vpc creation is not part of it.
- Make sure given pre-requisites are fulfilled
- run terraform
```
1. terraform init:
   This will download all necessary terraform plugins to support provisioning and configurations if any based on the provider we used.
2. terraform plan:
   This will give us summary of what all changes that we can expect upon execution of terraform scripts 
3. terraform apply:
   Lastly when we are sure of the changes and plan summary we can go ahead with provision by runnign this command
```

# Modules 
-  ecr:
   - This module has ecr repository provisioning code and it also runs one bash script (prep-installer.sh) for building docker image and pushing it to ECR.
   - Bash script will install all necesarry packages to build node app and will also create a proper directory structure for it
   - Dockerfile will also be created by prep-installer.sh ( bash script) which will copy node modules to the image such that when ran it should serve user requests flawlessly
   - Finally this module will build docker image and will tag it and push it to ECR repository that terraform has already created
- ecs_cluster:
  - This module creates a ecs cluster and name of the cluster will be picked from main.tf script
- ecs_task:
  - This module is used to create ecs task definition which will use docker image that we have build in very first module.
  - we have 2 scripts under it and one is ecs-iam which will create all required iam roles along with necessary permissions attached to it.
  - All details required for creating task definition will be passed from main.tf to it and have kept very minimal hard coded details in it such that we make change in main.tf should reflect at all the places.
  - A cloudwatch log group is also been created to keep observing what is happening inside the continaer when it's in running. This also helps in troubleshooting issues if any during the complete provisioning process.
  - This is a FARGATE cluster so we dont have to worry about EC2 and making it link with the cluster stuff here
- ecs_service:
  - This module creates ecs cluster service and runs task definition in it which is already been created in earlier module
  - In coming week will try to add autoscaling and loadbalancer support for this service. As of now this is at it's simplest form and service can be accessed through Public ip which will be assigned to it



