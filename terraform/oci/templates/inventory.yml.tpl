---
k3s_cluster:
  vars:
    ansible_port: 22
    ansible_user: ubuntu
    ansible_ssh_private_key_file: "../terraform/ssh_key"
    ansible_python_interpreter: /usr/bin/python3
    k3s_registration_address: ${ server_hosts[0].private_ip }
    k3s_become: true
    k3s_server:
      tls-san: "{{ ansible_host }}"

  hosts:
%{ for index, host in server_hosts ~}
    ${ host.hostname_label }:
      ansible_host: ${ host.public_ip }
      k3s_control_node: true
%{ endfor ~}

%{ for index, host in agent_hosts ~}
    ${ host.hostname_label }:
      ansible_host: ${ host.public_ip }
%{ endfor ~}