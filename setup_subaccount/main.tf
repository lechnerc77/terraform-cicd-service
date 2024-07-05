resource "random_uuid" "uuid" {}

locals {
  random_uuid               = random_uuid.uuid.result
  project_subaccount_domain = lower(replace("cicd-test-setup-${local.random_uuid}", "_", "-"))
}

resource "btp_subaccount" "sa-cicd" {
  name      = local.project_subaccount_domain
  subdomain = local.project_subaccount_domain
  region    = lower(var.region)
}
