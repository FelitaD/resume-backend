module "trigger" {
  source  = "../../modules/trigger"
}

module "functions" {
  source  = "../../modules/functions"
}

module "api" {
  source = "../../modules/api"
}
