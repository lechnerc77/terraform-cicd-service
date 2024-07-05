variable "globalaccount" {
  type        = string
  description = "The global account subdomain."
}

variable "region" {
  type        = string
  description = "The region where the project account shall be created in."
  default     = "us10"
}
