provider "google" {
  project = local.project
  region  = local.region
}

module "cloud_run" {
  source = "./modules/cloud_run"

  project              = local.project
  location             = local.location
  service_name         = local.service_name
  max_scale            = local.max_scale
  timeout_seconds      = local.timeout_seconds
  image                = local.image
  cpu                  = local.cpu
  memory               = local.memory
  service_account_name = local.service_account_name
  percent              = local.percent
  latest_revision      = local.latest_revision
}

module "cloud_scheduler" {
  source = "./modules/cloud_scheduler"

  scheduler_name        = local.scheduler_name
  schedule              = local.schedule
  time_zone             = local.time_zone
  attempt_deadline      = local.attempt_deadline
  retry_count           = local.retry_count
  max_doublings         = local.scheduler_max_doublings
  http_method           = local.http_method
  uri                   = local.uri
  audience              = local.audience
  service_account_email = local.service_account_email
}

module "cloud_tasks" {
  source = "./modules/cloud_tasks"

  name                      = local.task_name
  location                  = local.location
  max_concurrent_dispatches = local.max_concurrent_dispatches
  max_dispatches_per_second = local.max_dispatches_per_second
  max_attempts              = local.max_attempts
  max_backoff               = local.max_backoff
  min_backoff               = local.min_backoff
  max_doublings             = local.tasks_max_doublings
}

module "service_account" {
  source = "./modules/service_account"

  project      = local.project
  account_id   = local.account_id
  location     = local.location
  service_name = local.service_name
}
