variable "label_prefix" {
  type        = string
  default     = "cst8918-final-project-group-num-4"
  description = "This will form the beginning of various resource names."
}

variable "region" {
  default     = "canadacentral"
  description = "Resource region"
}

variable "environment" {
  description = "Environment name (test, prod, etc.)"
  type        = string
}

variable "min_count" {
  description = "Minimum node count for auto-scaling"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Maximum node count for auto-scaling"
  type        = number
  default     = 3
}

variable "node_count" {
  description = "Fixed node count when not using auto-scaling"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "VM size for the AKS nodes"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version to use"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for AKS"
  type        = string
}

variable "aks_name" {
  type = string
}