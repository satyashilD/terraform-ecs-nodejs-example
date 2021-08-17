output ecr_url {
  value       = module.ecr.ecr_url
}

output ecs_cluster { value =  module.ecs_cluster.cluster_id }