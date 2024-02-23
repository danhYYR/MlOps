# Extract the jumphost information
locals {
  jp_IP=lookup(var.jumphost_data,"hostname","127.0.0.1")
  jp_admin_name=lookup(var.jumphost_data,"username","127.0.0.1")
  jp_ssh_key=lookup(var.jumphost_data,"ssh_key","127.0.0.1")
}
# Prepare the Command
locals {
  ansible_cmd= <<-EOT
    ansible-playbook dynamic-host_plays.yml -e \"
        IP_address=${local.jp_IP} \
        admin_username=${local.jp_admin_name}}\
        ssh_key_file=${local.jp_ssh_key} \
        \"
  EOT
}