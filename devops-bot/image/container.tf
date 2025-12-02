resource "docker_registry_image" "registry_image" {
  name          = docker_image.bot_image.name
  keep_remotely = true
}

resource "docker_image" "bot_image" {
  name = "${var.acr_server_url}/coe-devops-bot"
  build {
    context = var.app_src_path
  }

}