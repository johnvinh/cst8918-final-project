variable "label_prefix" {
  type        = string
  default     = "cst8918-final-project-group"
  description = "This will form the beginning of various resource names."
}

variable "region" {
  default     = "canadacentral"
  description = "Resource region"
}

variable "resource_group_name" {
  type = string
}