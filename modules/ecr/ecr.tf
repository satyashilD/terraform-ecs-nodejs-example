resource "aws_ecr_repository" "ecr_repo" {
  name = var.ecr_name
}


# Run prep-installer script to push node image to ecr

data "template_file" "script" {
  template = "${file("${path.module}/prep-installer.tpl")}"

  vars = {
  ecr_url = "${aws_ecr_repository.ecr_repo.repository_url}"
  }
}

resource "null_resource" "ecr_image_push" {
 depends_on = [aws_ecr_repository.ecr_repo]
 provisioner "local-exec" {

    command = "bash  ${data.template_file.script.rendered}"
    interpreter = ["bash", "-c"]
  }
}

variable ecr_name {}

output ecr_url {
  value       = aws_ecr_repository.ecr_repo.repository_url
}
