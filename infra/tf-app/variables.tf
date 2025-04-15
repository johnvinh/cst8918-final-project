variable "label_prefix" {
  type        = string
  default     = "cst8918-final-project-group-num-4"
  description = "This will form the beginning of various resource names."
}

variable "region" {
  default     = "canadacentral"
  description = "Resource region"
}

variable "resource_group_name" {
  type = string
  description = "Resource group for main infrastructure"
}

variable "subscription_id" {
  description = "The Azure subscription to use for resources"
  type = string
}