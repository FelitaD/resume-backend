resource "google_artifact_registry_repository" "cloud-run-images" {
  location      = var.region
  repository_id = "cloud-run-resume"
  description   = "resume challenge images deployed to cloud run"
  format        = "DOCKER"
}

resource "google_cloudbuild_trigger" "resume-backend-trigger" {
  github {
    owner = "FelitaD"
    name  = "resume-backend"
    push {
       branch = "main"
      }
  }
  filename      = "terraform/cloudbuild-cloud-run-api.yaml"
  ignored_files = [".gitignore", "terraform/*"]
}

resource "google_cloud_run_v2_service" "api" {
  name     = "api"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "europe-west9-docker.pkg.dev/resume-404711/cloud-run-resume/cloud-run-backend-api"
    }
  }
}

resource "google_cloud_run_v2_service_iam_binding" "binding" {
  project = var.project
  location = var.region
  name = "allow_unauthenticated_users"
  role = "roles/run.invoker"
  members = [
    "allUsers",
  ]
}
