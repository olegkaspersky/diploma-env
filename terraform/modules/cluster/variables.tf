# project settings
variable "gcp_project" {
  description = "GCP project"
  type        = string
  sensitive   = true
}


variable "project_region" {
  description = "Default region for provisioned resources"
  type        = string
  sensitive   = true
}


variable "cluster_nodes_locations" {
  default = [
    "europe-north1-a",
    "europe-north1-b",
    "europe-north1-c"
  ]
  description = ""
}



# network settings
variable "network_name" {
  description = "Cluster VPC and subnetwork name"
  type        = string
  sensitive   = true
}


variable "subnet_range" {
  description = ""
  type        = string
  sensitive   = true
}



# cluster settings
variable "cluster_name" {
  description = "Cluster name"
  type        = string
  sensitive   = true
}


variable "cluster_nodes_tags" {
  default     = ["cluster-node"]
  description = "Nodes tags"
  type        = list(string)
  sensitive   = false
}


variable "cluster_nodes_machine_type" {
  default     = "e2-medium"
  description = "Default cluster nodes machine type"
  type        = string
  sensitive   = false
}


variable "cluster_nodes_disk_type" {
  default     = "pd-standard"
  description = "Cluster nodes disk type"
  type        = string
  sensitive   = false
}


variable "cluster_nodes_disk_size" {
  default     = 10
  description = "Cluster nodes disk size"
  type        = number
  sensitive   = false
}


variable "cluster_resource_labels" {
  default = {
    "environment" = "staging"
  }
  description = ""
  type        = map(string)
  sensitive   = false
}


variable "cluster_nodes_labels" {
  default = {
    "service"     = "kubernetes",
    "environment" = "staging"
  }
  description = ""
  type        = map(string)
}


variable "cluster_maintenance_reccurence" {
  default     = "FREQ=WEEKLY;BYDAY=TU,TH,SA"
  description = ""
  type        = string
  sensitive   = false
}


variable "cluster_maintenance_start_time" {
  default     = "2022-01-23T21:00:00Z"
  description = ""
  type        = string
  sensitive   = false
}


variable "cluster_maintenance_end_time" {
  default     = "2022-01-24T01:00:00Z"
  description = ""
  type        = string
  sensitive   = false
}



# cluster autoscaling settings
variable "minimum_cluster_node_count" {
  default     = 1
  description = ""
  type        = number
  sensitive   = false
}


variable "maximum_cluster_node_count" {
  default     = 3
  description = ""
  type        = number
  sensitive   = false
}


variable "cluster_node_min_machine_cpu_cores" {
  default     = 2
  description = ""
  type        = number
  sensitive   = false
}


variable "cluster_node_max_machine_cpu_cores" {
  default     = 4
  description = ""
  type        = number
  sensitive   = false
}


variable "cluster_node_min_machine_ram" {
  default     = 4
  description = ""
  type        = number
  sensitive   = false
}


variable "cluster_node_max_machine_ram" {
  default     = 8
  description = ""
  type        = number
  sensitive   = false
}


variable "max_cluster_nodes_unavailable" {
  default     = 1
  description = ""
  type        = number
  sensitive   = false
}


variable "max_cluster_nodes_surge" {
  default     = 1
  description = ""
  type        = number
  sensitive   = false
}
