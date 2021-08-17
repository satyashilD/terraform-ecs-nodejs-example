provider "aws" {
 region = var.region
}

module ecr {
    source = "./modules/ecr"
    ecr_name = var.ecr_name
}

module ecs_cluster {
    source = "./modules/ecs_cluster"
    cluster_name = var.cluster_name
}

module ecs_task {
    source = "./modules/ecs_task"
    container_cpu    = var.container_cpu
    container_memory = var.container_memory
    container_name   = var.container_name
    container_port   = var.container_port
    host_port        = var.host_port
    ecr_image        = "${module.ecr.ecr_url}:node_app"
    region = var.region
}

module ecs_service {
    source = "./modules/ecs_service"
    ecs_cluster_id =  module.ecs_cluster.cluster_id
    ecs_task_arn   = module.ecs_task.task_arn
    subnets        = var.subnets
    service_name   = var.service_name
}
