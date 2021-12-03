resource "kubernetes_service" "eks" {
  depends_on = [
    kubernetes_pod.eks
  ]
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

  timeouts {
    create = "60m"
    delete = "2h"
  }
}

resource "kubernetes_pod" "eks" {
  depends_on = [
    aws_security_group_rule.sec
  ]
  metadata {
    name = local.app_name
    labels = {
      app = local.app_name
    }
  }

  spec {
    container {
      image = var.image
      name  = local.app_name
    }
  }

  timeouts {
    create = "60m"
    delete = "2h"
  }
}