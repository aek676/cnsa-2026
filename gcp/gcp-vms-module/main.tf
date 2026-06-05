resource "google_compute_address" "external_ip" {
  name         = "${var.instance_name}-ip"
  project      = var.project_id
  region       = var.region
  address_type = "EXTERNAL"
}

resource "google_compute_instance" "vm" {
  name         = var.instance_name
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = var.subnet_id

    access_config {
      nat_ip = google_compute_address.external_ip.address
    }
  }

  metadata = {
    startup-script = var.startup_script != "" ? var.startup_script : null
    ssh-keys       = "${var.ssh_user}:${var.ssh_public_key}"
  }

  metadata_startup_script = var.startup_script != "" ? var.startup_script : null

  labels = {
    name = var.instance_name
  }

  tags = ["ssh", "http", "https", "jenkins"]
}
