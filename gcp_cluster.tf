# Configure the Google provider
provider "google" {
  project = "speedy-toolbox-360600"
  region  = "us-central1"
}

# Create 4 GKE cluster instances
resource "google_container_cluster" "primary" {
  count = 4
  name  = "montrealcollegecluster${count.index + 1}"
  location = "us-central1"

  # ... GKE cluster settings like node count, machine type etc
}
