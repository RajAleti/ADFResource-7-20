variable "resource_group_name" {
  default = "rg-test-adf-resources"
}
variable "location" {
  default = "West Europe"
}

variable "name" {
  default = "Datafactory-128-raja"
}

variable "keyvault_name" {
    default = "keyvault-storage-101"
  
}

variable "lkv_name" {
    default = "linkedkeyv"
  
}
variable "lbs_name" {
  default = "linkedblob"
}

variable "secret_name" {
  default = "Hakunamatata"
}

variable "self_ir_name" { 
    default = "self-ir"
  
}

variable "adf_pipeline_name" {
    default = "adf-pipeline-018"
  
}
