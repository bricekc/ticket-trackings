terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.0"
    }

        google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 7.0"
    }
  }
  backend "gcs" {
    bucket = "test-ovh-471114-terraform-state"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region = var.region
}

module "cloud_run" {
  source = "./cloud_run"
  cloud_run_name = "ticket-trackings-front"
  region = var.region
  ovh_domain = var.ovh_domain
  project_name = var.project_name
}
