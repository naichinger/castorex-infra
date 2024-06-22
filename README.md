# Create VMs with Terraform

# Create Cluster with Ansible

## Install dependencies

```
ansible-galaxy install -r galaxy_deps.yml
```

## Cloudflared

- Set: Zero Trust > Settings > Warp Client > Device enrollment permissions
- Remove: Zero Trust > Settings > Warp Client > Device Settings > [Edit Profile] > Split Tunnel > (Remove 10.0.0.0/8)

