# variable "label_prefix" {
#   type        = string
#   default     = "cst8918-final-project-group-num-4"
#   description = "This will form the beginning of various resource names."
# }

variable "region" {
  default     = "canadacentral"
  description = "Resource region"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for main infrastructure"
  default     = "cst8918-final-project-group-num-4"
}

variable "subscription_id" {
  description = "The Azure subscription to use for resources"
  default     = "4bd4f7fa-3cb3-4ee9-80fd-102513c31a0f"
  type        = string
}