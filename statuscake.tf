provider "statuscake" {
  username = var.status_cake_username
  apikey = var.status_cake_api_key
  version = "1.0.0"
}

locals {
  service_name = "${var.name}-${var.apigee_environment}"
  website_name = "https://${var.apigee_environment}.api.service.nhs.uk"
  ping_url = "${local.website_name}/${var.path}/_ping"
  status_url = "${local.website_name}/${var.path}/_status"
}

resource "statuscake_test" "ping" {
  website_name = "${local.service_name}-ping"
  website_url  = local.ping_url
  test_type    = "HTTP"
  check_rate   = 300
  contact_group   = [var.status_cake_contact_group]
  # Only deploy if namespace is empty. i.e don't create alerts for namespaced deployments
  count = length(var.namespace) > 0 ? 0 : 1
}

resource "statuscake_test" "status" {
  website_name =  "${local.service_name}-status"
  website_url  = local.status_url
  test_type    = "HTTP"
  check_rate   = 300
  contact_group   = [var.status_cake_contact_group]
  custom_header = jsonencode({"apikey": var.status_cake_status_apikey})
  # Only deploy if namespace is empty. i.e don't create alerts for namespaced deployments
  count = length(var.namespace) > 0 ? 0 : 1
}
