module "label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  enabled     = true
  attributes  = var.attributes
  environment = var.delivery_stage
  name        = var.component
  namespace   = var.application
  stage       = null
  tenant      = var.tenant
  context     = var.context

  label_order = [
    "namespace", # application
    "tenant",
    "environment", # delivery_stage
    "name",        # component
    "attributes",
  ]

  # namespace   tenant  env  name       attributes
  # opencounter-orlando-prod-cloudfront-ingress-443

  descriptor_formats = {
    stack = {
      labels = ["namespace", "environment"] # opencounter-prod
      format = "%v-%v"
    }
  }

  tags = merge({
    ManagedBy = "terraform"
    Application = local.application
  }, local.tags)
}

locals {
  application = coalesce(lookup(var.context, "namespace", null), var.application)
  tags = coalesce(lookup(var.context, "tags", {}), var.tags)
}
