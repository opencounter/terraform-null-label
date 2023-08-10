variable "application" {
  type        = string
  default     = null
  description = "required unless provided via context. logical name of the application this resource pertains to"
}

variable "stage" {
  type        = string
  default     = null
  description = "required unless provided via context. one of the deployment-stages outlined in our naming specification"
}

variable "environment" {
  type        = string
  default     = null
  description = "required unless provided via context. Unique name of the specific deployment environment, to distinguish among many in its `stage`. The environment can be named == `stage`, for singleton stages like prod and stag. This value is used in IDs, while stage is only used in Tags.Stage"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "optional list of strings to further qualify this label"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "optional extra tags to define as part of this label"
}

variable "component" {
  type        = string
  default     = null
  description = "optional name describing the thing you are labeling (eg. `app`, `worker`, `db`, `redis-store`)"
}

variable "context" {
  type = object({
    enabled             = bool
    namespace           = string
    environment         = string
    stage               = string
    name                = string
    delimiter           = string
    attributes          = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    regex_replace_chars = string
    label_order         = list(string)
    id_length_limit     = number
    label_key_case      = string
    label_value_case    = string
    descriptor_formats = map(object({
      labels = list(string)
      format = string
    }))
    labels_as_tags = list(string)
  })
  default = {
    enabled             = true
    namespace           = null
    tenant              = null
    environment         = null
    stage               = null
    name                = null
    delimiter           = null
    attributes          = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = null
    label_order         = []
    id_length_limit     = null
    label_key_case      = null
    label_value_case    = null
    descriptor_formats  = {}
    labels_as_tags      = ["unset"]
  }
  description = "optional. a context output from a parent label module which will be used to inherit from"
}

variable "tenant" {
  type        = string
  default     = null
  description = "used only when the resource being labeled is limited to one customer's service"
}

variable "id_length_limit" {
  type        = number
  default     = null
  description = "Limit id to this many characters (minimum 6).  Set to 0 for unlimited length.  Set to null for keep the existing setting, which defaults to 0.  Does not affect id_full."
}
