resource "random_uuid" "uuid" {}


locals {
  subaccount_domain = lower(replace("${var.subaccount_name}-${random_uuid.uuid.result}", "_", "-"))
}

resource "btp_subaccount" "cicd_subaccount" {
  name      = var.subaccount_name
  subdomain = local.subaccount_domain
  region    = lower(var.region)
}

resource "btp_subaccount_entitlement" "cicd_service" {
  subaccount_id = btp_subaccount.cicd_subaccount.id
  service_name  = "cicd-service"
  plan_name     = "default"
}

resource "btp_subaccount_entitlement" "cicd_app" {
  subaccount_id = btp_subaccount.cicd_subaccount.id
  service_name  = "cicd-app"
  plan_name     = "default"
}

resource "btp_subaccount_subscription" "cicd_app" {
  subaccount_id = btp_subaccount.cicd_subaccount.id
  app_name      = "cicd-app"
  plan_name     = "default"
  depends_on    = [btp_subaccount_entitlement.cicd_app]
}


data "btp_subaccount_service_plan" "ds_cicd_service_plan" {
  subaccount_id = btp_subaccount.cicd_subaccount.id
  name          = "default"
  offering_name = "cicd-service"
  depends_on    = [btp_subaccount_entitlement.cicd_service]
}

resource "btp_subaccount_service_instance" "cicd_service__default" {
  subaccount_id  = btp_subaccount.cicd_subaccount.id
  serviceplan_id = data.btp_subaccount_service_plan.ds_cicd_service_plan.id
  name           = "my-cicd-service-instance"
  depends_on     = [btp_subaccount_subscription.cicd_app]
}

resource "btp_subaccount_role_collection_assignment" "rca_cicd_admin" {
  subaccount_id        = btp_subaccount.cicd_subaccount.id
  role_collection_name = "CICD Service Administrator"
  user_name            = var.cicd_user_email
  depends_on           = [ btp_subaccount_service_instance.cicd_service__default ]
}

resource "btp_subaccount_role_collection_assignment" "rca_cicd_dev" {
  subaccount_id        = btp_subaccount.cicd_subaccount.id
  role_collection_name = "CICD Service Developer"
  user_name            = var.cicd_user_email
  depends_on           = [ btp_subaccount_service_instance.cicd_service__default ]
}