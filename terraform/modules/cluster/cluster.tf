data "google_project" "project" {
}


resource "google_container_cluster" "cluster" {
  #checkov:skip=CKV_GCP_24:Deprecated in Kubernetes 1.21
  #checkov:skip=CKV_GCP_65:We are not using G Suite Groups
  #checkov:skip=CKV_GCP_66:We are not using GCR

  provider = google-beta
  project  = var.gcp_project

  name                     = var.cluster_name
  location                 = var.project_region
  network                  = google_compute_network.cluster_network.id
  subnetwork               = google_compute_subnetwork.cluster_subnetwork.id
  initial_node_count       = 1
  remove_default_node_pool = true


  # cluster config
  min_master_version = "1.21"
  release_channel {
    channel = "STABLE"
  }

  enable_binary_authorization = false
  enable_intranode_visibility = true
  enable_kubernetes_alpha     = false
  enable_legacy_abac          = false
  enable_shielded_nodes       = true
  enable_tpu                  = false

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = true
    }
    dns_cache_config {
      enabled = true
    }
    gce_persistent_disk_csi_driver_config {
      enabled = true
    }
  }

  vertical_pod_autoscaling {
    enabled = true
  }

  maintenance_policy {
    recurring_window {
      recurrence = var.cluster_maintenance_reccurence
      start_time = var.cluster_maintenance_start_time
      end_time   = var.cluster_maintenance_end_time
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
    master_global_access_config {
      enabled = true
    }
  }

  resource_labels = var.cluster_resource_labels

  # cluster network config
  networking_mode = "VPC_NATIVE"

  default_snat_status {
    disabled = true
  }

  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
  }

  datapath_provider = "ADVANCED_DATAPATH"

  ip_allocation_policy {
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "85.143.144.87/32"
    }
  }


  # cluster nodes config
  cluster_autoscaling {
    enabled             = true
    autoscaling_profile = "BALANCED"

    auto_provisioning_defaults {
      image_type = "COS_CONTAINERD"
    }

    resource_limits {
      minimum       = var.cluster_node_min_machine_cpu_cores
      maximum       = var.cluster_node_max_machine_cpu_cores
      resource_type = "cpu"
    }

    resource_limits {
      minimum       = var.cluster_node_min_machine_ram
      maximum       = var.cluster_node_max_machine_ram
      resource_type = "memory"
    }
  }

  default_max_pods_per_node = 110

  node_config {
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    tags = var.cluster_nodes_tags

    labels = var.cluster_nodes_labels
  }

  workload_identity_config {
    workload_pool = "${data.google_project.project.project_id}.svc.id.goog"
  }


  # monitoring and logging config
  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS"
    ]
  }
  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS"
    ]
  }
}


resource "google_container_node_pool" "node_pool" {
  name     = var.cluster_name
  cluster  = google_container_cluster.cluster.id
  location = var.project_region

  autoscaling {
    min_node_count = var.minimum_cluster_node_count
    max_node_count = var.maximum_cluster_node_count
  }

  initial_node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  max_pods_per_node = 110

  node_locations = var.cluster_nodes_locations

  node_config {
    disk_size_gb = var.cluster_nodes_disk_size
    disk_type    = var.cluster_nodes_disk_type
    image_type   = "COS_CONTAINERD"
    machine_type = var.cluster_nodes_machine_type

    tags = var.cluster_nodes_tags

    metadata = {
      "disable-legacy-endpoints" = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append"
    ]

    shielded_instance_config {
      enable_integrity_monitoring = true
      enable_secure_boot          = true
    }

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = var.cluster_nodes_labels
  }

  upgrade_settings {
    max_surge       = var.max_cluster_nodes_surge
    max_unavailable = var.max_cluster_nodes_unavailable
  }
}
