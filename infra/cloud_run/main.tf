resource "google_cloud_run_v2_service" "ticket_trackings_front" {
  name     = var.cloud_run_name
  location = var.region
  deletion_protection = false
  ingress = "INGRESS_TRAFFIC_ALL"
  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        cpu_idle = true
        limits = {
          memory = "256Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "noauth" {
  location = google_cloud_run_v2_service.ticket_trackings_front.location
  project  = google_cloud_run_v2_service.ticket_trackings_front.project
  service  = google_cloud_run_v2_service.ticket_trackings_front.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_domain_mapping" "default" {
  location = google_cloud_run_v2_service.ticket_trackings_front.location
  name     = var.ovh_domain

  metadata {
    namespace = var.project_name
  }

  spec {
    route_name = google_cloud_run_v2_service.ticket_trackings_front.name
  }
}