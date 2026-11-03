variable "s3_bucket_config" {
    description = "Configuration for the s3 bucket"
    type = object({
        bucket_name = string
        environment = string
        versioning_enabled = bool
    })
    default = {
        bucket_name = "atu-mmgriffi-variables-bucket"
        environment = "dev"
        versioning_enabled = false
    }
}