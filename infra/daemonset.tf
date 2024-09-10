locals {
  image_name = "traefik/whoami"
  image_tag  = "latest"
}

resource "kubernetes_daemonset" "mpi_poc" {
  metadata {
    name      = "mpi-poc"
    namespace = "default"
    labels = {
      app     = "mpi-poc"
      version = "v0.1.0"
    }
  }

  spec {
    selector {
      match_labels = {
        app     = "mpi-poc"
        version = "v0.1.0"
      }
    }

    template {
      metadata {
        labels = {
          app     = "mpi-poc"
          version = "v0.1.0"
        }
      }

      spec {
        container {
          image = join(":", [local.image_name, local.image_tag])
          name  = "main"

          resources {
            limits = {
              cpu    = "1"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          port {
            container_port = 80
          }

          liveness_probe {
            http_get {
              path = "/whoami"
              port = 80
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}
