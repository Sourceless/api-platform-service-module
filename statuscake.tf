provider "statuscake" {
  username = var.status_cake_username
  apikey = var.status_cake_api_key
}

resource "statuscake_test" "google" {
  website_name = "google.com"
  website_url  = "www.google.com"
  test_type    = "HTTP"
  check_rate   = 300
  contact_group   = var.status_cake_contact_group
}
