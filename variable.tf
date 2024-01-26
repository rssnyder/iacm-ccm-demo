variable "name" {
  type    = string
  default = "iacm-ccm-demo"
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-682a8223", "subnet-e357d99a", "subnet-bef497e4"]
}

variable "vpc" {
  type    = string
  default = "vpc-51edc228"
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "ami" {
  type    = string
  default = "ami-0efcece6bed30fd98"
}

variable "ssm_instance_profile" {
  type    = string
  default = "ssm"
}

variable "hostedzone" {
  type    = string
  default = "Z2X614CI8JN37A"
}

variable "alb_arn" {
  type        = string
  description = "An existing ALB arn to use. If not set one will be created for you"
  default     = ""
}

variable "harness_cloud_connector_id" {
  type    = string
  default = "sales"
}
