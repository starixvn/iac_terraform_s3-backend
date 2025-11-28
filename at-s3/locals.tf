locals {
  project     = var.project
  environment = var.environment
  dept        = var.dept
  team        = var.team
  common_tags = {
    Dept         = upper(local.dept)
    #Team         = local.team
    ManageBy     = "vnTerraform"
    Environment  = upper(local.environment)
  }
}
