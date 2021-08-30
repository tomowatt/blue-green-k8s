resource "kubernetes_config_map" "app" {
  metadata {
    namespace     = var.namespace
    generate_name = "${var.env_version}-"
  }

  data = var.app_configmap
}