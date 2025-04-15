variable "label_prefix" {
  type        = string
  default     = "cst8918-final-project-group-num-4"
  description = "This will form the beginning of various resource names."
}

variable "region" {
  default     = "canadacentral"
  description = "Resource region"
}

variable "resource_group" {
  type = string
}

variable "aks_test_name" {
  type = string
}

variable "aks_prod_name" {
  type = string
}

variable "subnet_id" {
  type = string
}