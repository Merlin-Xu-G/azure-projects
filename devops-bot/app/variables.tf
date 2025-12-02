variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

# acr
variable "acr_server_url" {
  type = string
}

variable "acr_admin_username" {
  type = string
}

variable "acr_admin_password" {
  type = string
}

# image
variable "image_pushed" {
  type = bool
}

variable "wa_location" {
  type = string
  default = "Central US"
}