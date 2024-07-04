# Create k3s Cluster with Terraform and Ansible

# Infrastructure

Terraform creates the following resources:
- Hetzner Firewall
   - Allows Ingress on ports 80, 443, 22
   - Allows Egress on all ports (Hetzner default)
- Hetzner Network: 10.0.0.0/16
- Hetzner Subnetwork: 10.0.0.0/24
-  One Hetzner Server: Master Node
-  Hetzner Servers: Worker Nodes
   - Amount can be changed in terraform.tfvars
- Cloudflare DNS record
    - A RECORD for k3s.[domain.com]
    - CNAME RECORD for *.k3s.[domain.com] -> k3s.[domain.com]
- Cloudflare Tunnel
    - This Tunnel has access to the k3s internal service subnet and can access all services in the cluster.

Terraform also generates a ansible inventory file which is then used by ansible to deploy the k3s cluster with its default resources.

![img](docs/network.png)

# Create Cluster with Ansible


# Setup

## Install dependencies

1. 

```
ansible-galaxy install -r galaxy_deps.yml
```

## Cloudflared

- Set: Zero Trust > Settings > Warp Client > Device enrollment permissions
- Remove: Zero Trust > Settings > Warp Client > Device Settings > [Edit Profile] > Split Tunnel > (Remove 10.0.0.0/8)

