resource "null_resource" "basic_auth" {
  provisioner "local-exec" {
    command = "htpasswd -bc auth blue green"
  }
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [
    null_resource.basic_auth
  ]
  create_duration = "10s"
}

resource "null_resource" "basic_auth_secret" {
  provisioner "local-exec" {
    command = "kubectl -n ${kubernetes_namespace.blue_green.metadata[0].name} create secret generic basic-auth --from-file=auth"
  }

  depends_on = [
    time_sleep.wait_10_seconds
  ]
}

# resource "kubernetes_secret" "basic_auth" {
#   metadata {
#     namespace     = kubernetes_namespace.blue_green.metadata[0].name
#     generate_name = "basic-auth-"
#   }
#   data = file("./basic-auth")

#   depends_on = [
#     time_sleep.wait_10_seconds
#   ]
# }