module "blue" {
  source = "./modules/blue-green-deployment"

  namespace   = kubernetes_namespace.blue_green.metadata[0].name
  env_version = "blue-s"
  image       = "ghcr.io/tomowatt/blue-green:v1.0.0"
  port        = 8888
  app_configmap = {
    "PORT"  = 8888
    "TITLE" = "blue"
    "TEXT"  = "blue"
    "COLOR" = "blue"
  }
}

module "green" {
  source = "./modules/blue-green-deployment"

  namespace   = kubernetes_namespace.blue_green.metadata[0].name
  env_version = "green"
  image       = "ghcr.io/tomowatt/blue-green:v1.0.0"
  port        = 8888
  app_configmap = {
    "PORT"  = 8888
    "TITLE" = "green"
    "TEXT"  = "green"
    "COLOR" = "green"
  }
}
