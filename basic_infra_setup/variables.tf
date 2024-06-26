variable "globalaccount" {
  type        = string
  description = "The global account subdomain."
}

variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "test-cicd-service"
}

variable "region" {
  type        = string
  description = "The region where the project account shall be created in."
  default     = "us10"
}

variable "cicd_user_email" {
  type        = string
  description = "The email address of the user that shall be assigned the CICD roles."
}