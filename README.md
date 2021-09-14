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
   - This module has ecr repository provisioning code and it also runs one bash script (prep-installer.sh) for building docker image and pushing it to ECR.
   - Bash script will install all necesarry packages to build node app and will also create a proper directory structure for it
   - Dockerfile will also be created by prep-installer.sh ( bash script) which will copy node modules to the image such that when ran it should serve user requests flawlessly
   - Finally this module will build docker image and will tag it and push it to ECR repository that terraform has already created
- ecs_cluster:
  - This module creates a ecs cluster and name of the cluster will be picked from main.tf script
- ecs_task:
  - This module is used to create ecs task definition which will use docker image that we have build in very first module.
- ecs_service:
  - This module creates ecs cluster service and runs task definition in it which is already been created in earlier module



