resource "google_cloud_run_service" "default" {
  project  = var.project
  location = var.location
  name     = var.service_name

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = var.max_scale
      }
    }
    spec {
      timeout_seconds = var.timeout_seconds
      containers {
        image = var.image
        resources {
          limits = {
            "cpu"    = var.cpu
            "memory" = var.memory
          }
        }
        env {
          name  = "TZ"
          value = "Asia/tokyo"
        }
      }
      service_account_name = var.service_account_name
    }
  }

  traffic {
    percent         = var.percent
    latest_revision = var.latest_revision
  }

  lifecycle {
    ignore_changes = [
      template["spec"]
    ]
  }
}

output "cloud_run_url" {
  value = "${google_cloud_run_service.default.status[0].url}/"
}
