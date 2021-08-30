module "blue" {
  source = "./modules/blue-green-deployment"

  namespace        = kubernetes_namespace.blue_green.metadata[0].name
  env_version      = "blue-s"
  image            = "ghcr.io/tomowatt/blue-green:v1.0.0"
  port             = 8888
  app_config_title = "blue"
  app_config_text  = "blue"
  app_config_color = "blue"
}

module "green" {
  source = "./modules/blue-green-deployment"

  namespace        = kubernetes_namespace.blue_green.metadata[0].name
  env_version      = "green"
  image            = "ghcr.io/tomowatt/blue-green:v1.0.0"
  port             = 8888
  app_config_title = "green"
  app_config_text  = "green"
  app_config_color = "green"
}
