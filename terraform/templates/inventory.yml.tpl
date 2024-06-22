---
k3s_cluster:
  vars:
    ansible_port: 22
    ansible_user: root
    ansible_ssh_private_key_file: "../terraform/ssh_key"
    ansible_python_interpreter: /usr/bin/python3
    k3s_registration_address: ${ server_hosts[0].network.*.ip[0] }
    k3s_become: true
    # k3s_server:
    #   tls-san: "{{ ansible_host }}"

    cloudflare_token: "${ cloudflare_token }"
    letsencrypt_email: "$ { letsencrypt_email }"
    cloudflare_tunnel_secret: "${ cloudflare_tunnel_secret }"
    argocd_pw: "${ argocd_pw }"

  hosts:
%{ for index, host in server_hosts ~}
    ${ host.name }:
      ansible_host: ${ host.ipv4_address }
      k3s_control_node: true
%{ endfor ~}

%{ for index, host in agent_hosts ~}
    ${ host.name }:
      ansible_host: ${ host.ipv4_address }
%{ endfor ~}