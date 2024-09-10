terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.27.0"
    }
  }

  required_version = "~> v1.8"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "k3d-mpi"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "k3d-mpi"
}
