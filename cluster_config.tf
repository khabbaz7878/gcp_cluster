resource "google_service_account" "default" {
 account_id   = var.account_id
 display_name = var.display_name
 project = var.projectid
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}
# Create 4 GKE cluster instances
resource "google_container_cluster" "primary" {
  count = 4
  name  = "montrealcollegecluster${count.index + 1}"
  location = "us-central1"

  # ... GKE cluster settings like node count, machine type etc
}
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
   service_account = var.service_account
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
