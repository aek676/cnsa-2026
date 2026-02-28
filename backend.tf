terraform {
  required_version = ">= 1.14"
  cloud {
    organization = "aek676"
    workspaces {
      name = "cnsa2026-aek676"
    }
  }
}
