resource "kubernetes_service" "eks" {
  metadata {
    name = local.app_name
  }
  spec {
    selector = {
      app = kubernetes_pod.eks.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "eks" {
  metadata {
    name = local.app_name
    labels = {
      app = local.app_name
    }
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = local.app_name
    }
  }
}