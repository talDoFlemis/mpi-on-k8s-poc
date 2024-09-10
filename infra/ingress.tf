resource "kubernetes_ingress" "mpi_ingress" {
  metadata {
    name = "mpi-ingress"
    annotations = {
      "ingress.kubernetes.io/ssl-redirect" = "false"
    }
  }

  spec {
    rule {
      host = "mpi.localhost"
      http {
        path {
          path = "/"
          backend {
            service_name = kubernetes_service.mpi_service.metadata[0].name
            service_port = 8080
          }
        }
      }
    }
  }
}
