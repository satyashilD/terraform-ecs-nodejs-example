
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

variable cluster_name {}

output cluster_name { value = aws_ecs_cluster.ecs_cluster.name}
output cluster_id { value = aws_ecs_cluster.ecs_cluster.id}