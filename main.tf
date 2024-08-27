provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name = "webapp-vpc"
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "webapp-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_instance" "app_server" {
  name         = "webapp-server"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "rhel-cloud/rhel-9"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {}
  }

  metadata_startup_script = file("scripts/startup-script.sh")

  tags = ["webapp-server"]
}

resource "google_sql_database_instance" "webapp_db" {
  name             = "webapp-db"
  database_version = "POSTGRES_13"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

resource "google_sql_database" "db" {
  name     = "appdb"
  instance = google_sql_database_instance.webapp_db.name
}

resource "google_sql_user" "users" {
  name     = "webapp_user"
  instance = google_sql_database_instance.webapp_db.name
  password = var.db_password
}

resource "google_compute_firewall" "default-allow-http" {
  name    = "allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["webapp-server"]
}

resource "google_compute_firewall" "default-allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["webapp-server"]
}

resource "google_compute_firewall" "allow-db-connection" {
  name    = "allow-db-connection"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_tags = ["webapp-server"]
  target_tags = ["sql-server"]
}
