terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.0"
    }
  }
}


provider "google-beta" {
}
provider "google" {
  credentials = file("/path/to/credentials.json")

  # other provider settings  
}
