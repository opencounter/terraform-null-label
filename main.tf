module "label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  enabled     = true
  attributes  = var.attributes
  environment = var.delivery_stage
  name        = var.component
  namespace   = var.application
  stage       = var.stage
  tenant      = var.tenant
  context     = var.context

  label_order = [
    "namespace", # application
    "environment",
    "tenant",
    "name", # component
    "attributes",
  ]

  # namespace  stage tenant  name       attributes
  # opencounter-prod-orlando-cloudfront-ingress-443

  descriptor_formats = {
    stack = {
      labels = ["namespace", "environment"] # opencounter-prod
      format = "%v-%v"
    }
    qualified_environment = {
      labels = ["stage", "environment"]
      format = "%v-%v"
    }
  }

  tags = merge({
    ManagedBy   = "terraform"
    Application = local.application
  }, local.tags)
}

locals {
  application = coalesce(lookup(var.context, "namespace", null), var.application)
  tags        = coalesce(lookup(var.context, "tags", {}), var.tags)
}
