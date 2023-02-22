# Variables
variable "lab-name" {
  type        = string
  description = "Name to be used for resources in this lab"
}
variable "environment_tag" {
  type        = string
  description = "Environment tag value"
}
variable "region1" {
  type        = string
  description = "location 1 for the lab"
}
variable "region2" {
  type        = string
  description = "location 2 for the lab"
}