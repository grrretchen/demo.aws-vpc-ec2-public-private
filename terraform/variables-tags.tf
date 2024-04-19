# project tags
variable "owner" {
  type = string
}
variable "project_name" {
  type = string
}
variable "repo" {
  type = string
}

# label tags
variable "namespace" {
  type = string
  default = ""
}
variable "environment" {
  type = string
  default = ""
}
variable "stage" {
  type = string
  default = ""
}
variable "tags" {
  type = map(string)
  default = {}
}
