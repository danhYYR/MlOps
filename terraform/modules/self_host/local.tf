# Extract the jumphost information
locals {
  jp_name       = lookup(var.jumphost_data, "name", "jumphost")
  jp_IP         = lookup(var.jumphost_data, "hostname", "127.0.0.1")
  jp_admin_name = lookup(var.jumphost_data, "username", "127.0.0.1")
  jp_ssh_key    = lookup(var.jumphost_data, "ssh_key", "127.0.0.1")
}
# Prepare the Ansible Variable file
locals {
  ansible_vars = <<-EOT
    # Local Inventory path
    local_file: "${path.cwd}/${var.inventory_path}"
    # JumpHost Variable
    IP_address: "${local.jp_IP}"
    ssh_key_file: "${local.jp_ssh_key}"
    admin_username: "${local.jp_admin_name}"
    # AKS Variable
    aks_name: "${var.aks_name}"
    # Global variable
    rg_name: "${var.rg_name}"
    rg_location: "${var.rg_location}"
  EOT
}

# Prepare the Command
locals {
  activate_venv     = <<EOT
    workon vdemoansible
  EOT
  ansible_workspace = <<EOT
    cd ../ansible 
  EOT
  /*
  // The Input Variable for ansible playbook prepare the local inventory:
    IP_address is the IP address of the Jumphost VM
    admin_username is the admin user of the Jumphost VM
    ssh_key_file is the path of private key to setup the ssh connection
    // AKS variable
    aks_name is the private AKS name
    // Global variable
    rg_name is the resource group of project's name
    rg_location is the location of resource group project
  //
  */
  ansible_cmd = <<EOT
    ansible-playbook dynamic-host_plays.yml --extra-var "@${local_file.inventory_variable.filename}"
  EOT
}
// Setup for dynamic inventory template
locals {
  inventory_azure = <<-EOT
    plugin: azure_rm
    include_vm_resource_groups:
      - "${var.rg_name}"
    conditional_groups:
      "${local.jp_name}": "'${local.jp_name}' in computer_name"
    auth_source: cli
    hostvar_expressions:
      ansible_ssh_private_key_file: "'${local.jp_ssh_key}'"
      ansible_user: "'${local.jp_admin_name}'"
EOT
}
