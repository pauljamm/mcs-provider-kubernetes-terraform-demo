terraform {
  required_providers {
    mcs = {
      source  = "MailRuCloudSolutions/mcs"
      version = "~> 0.5.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.35.0"
    }
  }
}
