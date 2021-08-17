# terraform-ecs-nodejs-example

# pre-requisites:
- aws cli 
- docker
- terraform

# Flow of execution
- Update terraform.tfvars with correct details according to your test need. SUbnets and region should be passed to these scripts as vpc creation is not part of it.
- Make sure given pre-requisites are fulfilled
- run terraform

# Modules 
-  ecr:
- - This module has ecr repository provisioning code and it also runs one bash script for building docker image and pushing it to ECR
- ecs_cluster:
- - This module creates a ecs cluster and name of the cluster will be picked from main.tf script
- ecs_task:
- - This module is used to create ecs task definition which will use docker image that we have build in very first module.
- ecs_service:
- - This module creates ecs cluster service and runs task definition in it which is already been created in earlier module



