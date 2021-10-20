# Runs
resource "null_resource" "serverless_package" {
  provisioner "local-exec" {
    command = "cd ${app_dir}; serverless package -p ${path.root}/${var.app_artifact}"
  }
}