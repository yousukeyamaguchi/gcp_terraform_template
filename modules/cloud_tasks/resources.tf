resource "google_cloud_tasks_queue" "tasks" {
  name     = var.name
  location = var.location

  rate_limits {
    max_concurrent_dispatches = var.max_concurrent_dispatches
    max_dispatches_per_second = var.max_dispatches_per_second
  }

  retry_config {
    max_attempts  = var.max_attempts
    max_backoff   = var.max_backoff
    min_backoff   = var.min_backoff
    max_doublings = var.max_doublings
  }
}
