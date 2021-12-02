resource "kubernetes_service" "eksdemo" {
  metadata {
    name = "terraform-eksdemo"
  }
  spec {
    selector = {
      app = kubernetes_pod.eksdemo.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "eksdemo" {
  metadata {
    name = "terraform-eksdemo"
    labels = {
      app = "MyApp"
    }
  }

  spec {
    container {
      image = "nginx:1.7.9"
      name  = "eksdemo"
    }
  }
}