# project settings
variable "gcp_project" {
  description = "GCP project."
  type        = string
  sensitive   = true
}


variable "project_region" {
  description = "Default region for provisioned resources."
  type        = string
  sensitive   = true
}


variable "cluster_nodes_locations" {
  default = [
    "europe-north1-a",
    "europe-north1-b",
    "europe-north1-c"
  ]
  description = "Cluster nodes locations."
}



# network settings
variable "network_name" {
  description = "Cluster VPC and subnetwork name."
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
  description = "Cluster name."
  type        = string
  sensitive   = true
}


variable "cluster_nodes_tags" {
  default     = ["cluster-node"]
  description = "Clsuter nodes tags."
  type        = list(string)
  sensitive   = false
}


variable "cluster_nodes_machine_type" {
  default     = "e2-highcpu-2"
  description = "Default cluster nodes machine type."
  type        = string
  sensitive   = false
}


variable "cluster_nodes_disk_type" {
  default     = "pd-standard"
  description = "Cluster nodes disk type."
  type        = string
  sensitive   = false
}


variable "cluster_nodes_disk_size" {
  default     = 10
  description = "Cluster nodes disk size."
  type        = number
  sensitive   = false
}


variable "cluster_resource_labels" {
  default = {
    "environment" = "placeholder"
  }
  description = ""
  type        = map(string)
  sensitive   = false
}


variable "cluster_nodes_labels" {
  default = {
    "service"     = "kubernetes",
    "environment" = "environment"
  }
  description = ""
  type        = map(string)
}


variable "cluster_maintenance_reccurence" {
  default     = "FREQ=WEEKLY;BYDAY=TU,TH,SA"
  description = "Cluster maintenance days."
  type        = string
  sensitive   = false
}


variable "cluster_maintenance_start_time" {
  default     = "2022-01-23T21:00:00Z"
  description = "Cluster maintenance start time."
  type        = string
  sensitive   = false
}


variable "cluster_maintenance_end_time" {
  default     = "2022-01-24T01:00:00Z"
  description = "Cluster maintenance end time."
  type        = string
  sensitive   = false
}



# cluster autoscaling settings
variable "minimum_cluster_node_count" {
  default     = 1
  description = "Minimum number of nodes in the zone."
  type        = number
  sensitive   = false
}


variable "maximum_cluster_node_count" {
  default     = 3
  description = "Maximum number of nodes in the zone."
  type        = number
  sensitive   = false
}


# variable "cluster_node_min_machine_cpu_cores" {
#   default     = 6
#   description = "Minimum number of cpu cores in cluster."
#   type        = number
#   sensitive   = false
# }
# 
# 
# variable "cluster_node_max_machine_cpu_cores" {
#   default     = 18
#   description = "Maximum number of cpu cores in cluster."
#   type        = number
#   sensitive   = false
# }
# 
# 
# variable "cluster_node_min_machine_ram" {
#   default     = 6
#   description = ""
#   type        = number
#   sensitive   = false
# }
# 
# 
# variable "cluster_node_max_machine_ram" {
#   default     = 18
#   description = ""
#   type        = number
#   sensitive   = false
# }


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
