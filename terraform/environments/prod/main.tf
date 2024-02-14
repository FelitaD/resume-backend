module "trigger" {
  source  = "../../modules/trigger"
}

module "functions" {
  source  = "../../modules/functions"
}


# module "api" {
#   source = "../../modules/api"
# }


# # API backend

# # Create Artifact repository to store API image

# resource "google_artifact_registry_repository" "default" {
#   location      = var.region
#   repository_id = "api-registry"
#   description   = "Registry containing API image to deploy to Cloud Run"
#   format        = "DOCKER"
# }

# # Create Cloud Build trigger to build and push image to Artifact Registry when push on main branch

# resource "google_cloudbuild_trigger" "default" {
#   github {
#     owner = "FelitaD"
#     name  = "resume-backend"
#     push {
#        branch = "main"
#       }
#   }
#   filename      = "terraform/cloudbuild_api.yaml"
#   ignored_files = [".gitignore", "terraform/*"]
# }

# # Deploy API backend on Cloud Run

# resource "google_cloud_run_v2_service" "api" {
#   name     = "api"
#   location = var.region
#   ingress  = "INGRESS_TRAFFIC_ALL"

#   template {
#     containers {
#       image = "europe-west9-docker.pkg.dev/resume-404711/api-registry/api_image"
#     }
#   }
# }

# # Allow unauthenticated requests on API backend

# resource "google_cloud_run_v2_service_iam_member" "default" {
#   project = google_cloud_run_v2_service.api.project
#   location = google_cloud_run_v2_service.api.location
#   name = google_cloud_run_v2_service.api.name
#   role = "roles/run.invoker"
#   member = "allUsers"
# }

# # Gateway

# # Reserve hostname for Gateway on Cloud Run

# resource "google_cloud_run_v2_service" "gateway" {
#   name     = "gateway"
#   location = var.region
#   ingress  = "INGRESS_TRAFFIC_ALL"

#   template {
#     containers {
#       image = "gcr.io/cloudrun/hello"
#     }
#   }
# }

# # Allow unauthenticated requests on Gateway

# # resource "google_cloud_run_v2_service_iam_member" "gateway" {
# #   project = google_cloud_run_v2_service.gateway.project
# #   location = google_cloud_run_v2_service.gateway.location
# #   name = google_cloud_run_v2_service.gateway.name
# #   role = "roles/run.invoker"
# #   member = "allUsers"
# # }

# # Create Cloud Endpoints endpoint for Gateway service

# resource "google_endpoints_service" "default" {
#   service_name   = "gateway-jq4t4jadfq-od.a.run.app"
#   project        = var.project
#   openapi_config = file("/Users/donor/Code/resume-challenge/resume-backend/gateway/openapi-run.yaml")
# }

# # [Manual step] Build ESPv2 image from script

# # Deploy Gateway revision (ESPv2) on Cloud Run

# resource "google_cloud_run_v2_service" "gateway-espv2" {
#   name     = "gateway"
#   location = var.region
#   ingress  = "INGRESS_TRAFFIC_ALL"

#   template {
#     containers {
#       image = "eu.gcr.io/resume-404711/endpoints-runtime-serverless:2.46.0-gateway-jq4t4jadfq-od.a.run.app-2024-01-02r0"
#     }
#   }
# }

# # [Useless ?] Allow unauthenticated requests on Gateway revision

# resource "google_cloud_run_v2_service_iam_member" "gateway-espv2" {
#   project = google_cloud_run_v2_service.gateway-espv2.project
#   location = google_cloud_run_v2_service.gateway-espv2.location
#   name = google_cloud_run_v2_service.gateway-espv2.name
#   role = "roles/run.invoker"
#   member = "allUsers"
# }
