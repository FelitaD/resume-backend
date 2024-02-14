resource "google_cloudbuild_trigger" "backend-infra-trigger" {
  github {
    owner = "FelitaD"
    name  = "resume-backend"
    push {
       branch = ".*"
      }
  }
  filename      = "cloudbuild.yaml"
  ignored_files = [".gitignore"]
}