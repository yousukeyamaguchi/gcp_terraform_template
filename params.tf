locals {
  customer = "your-customer"
  surfix   = "main"
  project  = "${local.customer}-${local.surfix}"
  region   = "us-central1"
  location = "asia-northeast1"
  # cloud run config
  service_name         = "cloud-run-service-${local.project}"
  max_scale            = "20"
  timeout_seconds      = 1200
  image                = "us-docker.pkg.dev/cloudrun/container/hello"
  cpu                  = "1000m"
  memory               = "512Mi"
  service_account_name = module.service_account.run_invoker_email
  percent              = 100
  latest_revision      = true
  # cloud scheduler config
  scheduler_name          = ["kick-${local.project}", "restart-${local.project}"]
  schedule                = ["0 3 * * *", "0 6 * * *"]
  time_zone               = "Asia/Tokyo"
  attempt_deadline        = "320s"
  retry_count             = 3
  scheduler_max_doublings = 5
  http_method             = "GET"
  uri                     = [module.cloud_run.cloud_run_url, "https://www.yahoo.co.jp/"]
  audience                = [module.cloud_run.cloud_run_url, ""]
  service_account_email   = [module.service_account.run_invoker_email, ""]
  # cloud tasks config
  task_name                 = "tasks-queue-${local.project}"
  max_concurrent_dispatches = 10
  max_dispatches_per_second = 1
  max_attempts              = 10
  max_backoff               = "3600s"
  min_backoff               = "0.100s"
  tasks_max_doublings       = 16
  # service account config
  account_id = "cloud-run-sa-${local.project}"
}
