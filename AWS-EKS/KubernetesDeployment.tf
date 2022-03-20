resource "kubernetes_deployment" "sampleappdeployment" {
  metadata {
    name = "sampleappdeployment"
    labels = {
      app = "sampleApplication"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "sampleApplication"
      }
    }

    template {
      metadata {
        labels = {
          app = "sampleApplication"
        }
      }

      spec {
        container {
          image = "tashikmoin/cicd-vps:latest"
          name  = "sampleApplicationContainer"
        }
      }
    }
  }
}
