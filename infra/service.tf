resource "kubernetes_service" "mpi_service" {
  metadata {
    name = "mpi-service"
  }

  spec {
    selector = {
      app     = kubernetes_daemonset.mpi_poc.metadata[0].labels.app
      version = kubernetes_daemonset.mpi_poc.metadata[0].labels.version
    }

    port {
      protocol    = "TCP"
      port        = 8080
      target_port = kubernetes_daemonset.mpi_poc.spec[0].template[0].spec[0].container[0].port[0].container_port
      name        = "web"
    }

    type = "ClusterIP"
  }
}
