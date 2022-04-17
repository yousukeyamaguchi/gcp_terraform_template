resource "google_service_account" "run_invoker" {
  project      = var.project
  account_id   = var.account_id
  display_name = "cloud run invoker service account"
}

data "google_iam_policy" "invoker" {
  binding {
    role = "roles/run.invoker"
    members = [
      "serviceAccount:${google_service_account.run_invoker.email}"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "run_policy" {
  location    = var.location
  project     = var.project
  service     = var.service_name
  policy_data = data.google_iam_policy.invoker.policy_data
}

output "run_invoker_email" {
  value = google_service_account.run_invoker.email
}
