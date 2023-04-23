terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("squid-384603-2bbd2176ebcc.json")

  project = "YOUR GCP PROJECT ID"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "default" {
  name         = "squid"
  machine_type = "e2-micro"
  zone         = "us-central1-c"

  metadata = {
    ssh-keys = "USERNAME:an SSH pubkey to inject into your server"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  service_account {
    email  = "YOUR GCP SERVICE ACCOUNT"
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_firewall" "default" {
  name = "allow-squid"
  network = "default"

  allow { 
    protocol = "tcp"
    ports = ["3128"]
  }

  source_ranges = ["THE CIDR YOU WANT TO CONNECT FROM"]
}