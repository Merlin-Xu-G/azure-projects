dependency "acr" {
  config_path = "../acr"
  mock_outputs = {
    acr_server_url = "merlintestregistry.azurecr.io"
    acr_admin_username = "mock_acr_admin_username"
    acr_admin_password = "mock_acr_admin_password"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "fmt"]
}

inputs = {
  acr_server_url = dependency.acr.outputs.acr_server_url
  acr_admin_username = dependency.acr.outputs.acr_admin_username
  acr_admin_password = dependency.acr.outputs.acr_admin_password
  app_src_path = "${get_terragrunt_dir()}/app"
}