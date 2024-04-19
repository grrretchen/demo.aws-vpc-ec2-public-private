module "tags" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace   = var.namespace
  environment = var.environment
  stage       = var.stage
  attributes  = [var.project_name]
  delimiter   = "-"

  tags = {
    "Project"        = var.project_name
    "Project Owner"  = var.owner
    "Project Source" = var.repo
  }
}