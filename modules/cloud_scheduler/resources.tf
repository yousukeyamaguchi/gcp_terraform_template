resource "google_cloud_scheduler_job" "scheduler" {
  count            = length(var.scheduler_name)
  name             = var.scheduler_name[count.index]
  schedule         = var.schedule[count.index]
  time_zone        = var.time_zone
  attempt_deadline = var.attempt_deadline

  retry_config {
    retry_count   = var.retry_count
    max_doublings = var.max_doublings
  }

  http_target {
    http_method = var.http_method
    uri         = var.uri[count.index]

    oidc_token {
      audience              = var.audience[count.index]
      service_account_email = var.service_account_email[count.index]
    }
  }

  lifecycle {
    ignore_changes = [
      http_target["oidc_token"]
    ]
  }
}
