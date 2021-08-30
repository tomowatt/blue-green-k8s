resource "kubernetes_config_map" "app" {
  metadata {
    namespace     = var.namespace
    generate_name = "${var.env_version}-"
  }

  data = {
    "PORT"  = var.port
    "TITLE" = var.app_config_title
    "TEXT"  = var.app_config_text
    "COLOR" = var.app_config_color
  }
}