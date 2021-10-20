# Runs a serverless package command to create artifact
resource "null_resource" "serverless_package" {
  provisioner "local-exec" {
    command = "cd ${var.app_dir}; serverless package -p ${path.root}/${var.app_artifact}"
  }

}