variable "region" {
  default     = "canadacentral"
  description = "Resource region"
}
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "cst8918-final-project-group-4"
}
variable "redis_name" {
  description = "The name of the Redis cache"
  type        = string
}
variable "environment" {
  description = "The environment (test or prod)"
  type        = string
  default     = "weather-cache"
}