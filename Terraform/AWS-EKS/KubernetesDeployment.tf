resource "kubernetes_deployment" "sampleappdeployment" {
  metadata {
    name = "sampleappdeployment"
    labels = {
      app = "sampleapplication"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "sampleapplication"
      }
    }

    template {
      metadata {
        labels = {
          app = "sampleapplication"
        }
      }

      spec {
        container {
          image = "tashikmoin/cicd-vps:latest"
          name  = "sampleapplicationcontainer"
        }
      }
    }
  }
}
