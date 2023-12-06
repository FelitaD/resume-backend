terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_cloud_run_v2_service" "api" {
  name     = "cloudrun-api"
  location = "europe-west9"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = ""
    }
  }
}