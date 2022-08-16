locals {
  #Governance tags
  commonTags = {
    environment    = "${var.dpt_prefix}-${var.env_prefix}"
  }
}
