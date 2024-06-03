# variables.tf - variable definitions for the root module

variable "forgerock" {
  description = "ForgeRock employee settings"
  type = object({
    employee        = bool
    billing_entity  = string

    es_useremail    = string
    es_businessunit = string
    es_ownedby      = string
    es_managedby    = string
    es_zone         = string
  })

  default = {
    employee        = null
    billing_entity  = null

    es_useremail    = null
    es_businessunit = null
    es_ownedby      = null
    es_managedby    = null
    es_zone         = null
  }
}

variable "cluster" {
  description = "Cluster settings"
  type = object({
    type = string
    auth = map(string)
    meta = object({
      cluster_name       = string
      kubernetes_version = string
    })

    location = object({
      region = string
      zones  = list(string)
    })

    node_pools = map(object({
      type          = string
      initial_count = number
      min_count     = number
      max_count     = number
      disk_size_gb  = optional(number)
      labels        = optional(map(string))
      taints        = optional(list(object({
        key    = string
        value  = string
        effect = string
      })))
      meta          = object({
        zones        = optional(list(string))

        default_pool = optional(bool)
      })
    }))

    helm = map(
      map(string)
    )
  })

  default = {
    type = null
    auth = null
    meta = null

    location = {
      region = null
      zones  = null
    }

    node_pools = {}
    helm = {}
  }
}

