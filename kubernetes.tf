# Redis Deployment
resource "kubernetes_deployment" "redis" {
  metadata {
    name = "redis"
    labels = {
      app = "redis"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          app = "redis"
        }
      }

      spec {
        container {
          image = "redis:alpine"
          name  = "redis"

          port {
            container_port = 6379
          }
        }
      }
    }
  }
}

# Redis Service (internal only)
resource "kubernetes_service" "redis" {
  metadata {
    name = "redis"
  }
  spec {
    selector = {
      app = "redis"
    }
    port {
      port        = 6379
      target_port = 6379
    }
    type = "ClusterIP"
  }
}

# Web App Deployment
resource "kubernetes_deployment" "web" {
  metadata {
    name = "web"
    labels = {
      app = "webapp"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        container {
          image = "devopsjuly22017/web:latest"
          name  = "web"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

# Web App Service (public)
resource "kubernetes_service" "websvc" {
  metadata {
    name = "websvc"
  }
  spec {
    selector = {
      app = "webapp"
    }
    port {
      port        = 80
      target_port = 5000
    }
    type             = "LoadBalancer"
    load_balancer_ip = google_compute_address.webapp_static_ip.address
  }
}