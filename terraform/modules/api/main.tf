resource "google_api_gateway_api" "default" {
  provider = google-beta
  api_id = "api"
}

resource "google_api_gateway_api_config" "default" {
  provider = google-beta
  api = google_api_gateway_api.default.api_id
  api_config_id = "resume-api-config"

  openapi_documents {
    document {
      path = "spec.yaml"
      contents = filebase64("../../../src/api/openapi2-functions.yaml")
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "default" {
  provider = google-beta
  api_config = google_api_gateway_api_config.default.id
  gateway_id = "resume-gateway"
  region = "europe-west1"
}