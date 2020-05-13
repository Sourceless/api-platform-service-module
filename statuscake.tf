provider "statuscake" {
  username = var.status_cake_username
  apikey = var.status_cake_api_key
}

locals {
  website_name = "${var.apigee_environment}.api.service.nhs.uk"
  ping_url = "${local.website_name}/${var.path}/_ping"
  status_url = "${local.website_name}/${var.path}/_status"
}

resource "statuscake_test" "ping" {
  website_name = local.website_name
  website_url  = local.ping_url
  test_type    = "HTTP"
  check_rate   = 300
  contact_group   = [var.status_cake_contact_group]
}

resource "statuscake_test" "status" {
  website_name = local.website_name
  website_url  = local.status_url
  test_type    = "HTTP"
  check_rate   = 300
  contact_group   = [var.status_cake_contact_group]
}
