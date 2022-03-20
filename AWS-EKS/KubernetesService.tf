resource "kubernetes_service" "sampleappservice" {
  metadata {
    name = "sampleappservice"
  }
  spec {
    selector = {
      app = "sampleApplication"
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
