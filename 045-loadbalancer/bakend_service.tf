# Backend Service
resource "google_compute_backend_service" "backend" {
  provider    = google-beta
  name        = "ialejandro-backend"
  description = "backend service ialejandro"

  connection_draining_timeout_sec = 100
  port_name                       = "http"
  protocol                        = "HTTP"
  timeout_sec                     = 10
  load_balancing_scheme           = "EXTERNAL"

  backend {
    balancing_mode        = "UTILIZATION"
    group                 = google_compute_instance_group_manager.webservers.instance_group
    max_rate_per_instance = 1
  }

  health_checks = [google_compute_health_check.health_check.self_link]
}

# HC
resource "google_compute_health_check" "health_check" {
  provider           = google-beta
  name               = "ialejandro-check-webserver"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "80"
  }
}