# vms with oci

## Steps
1. Log into Oracle Cloud
2. Top Right Corner Profile Icon > My Profile > API keys
3. Click on "Add API key"
4. Click on "Add"
5. Copy values from "Config file preview" over to terraform.tf.vars:
```
[DEFAULT]
user=<user_ocid>
fingerprint=<fingerprint>
tenancy=<compartment_ocid>
region=<region>
key_file=<private_key_path>
```

# Useful resources
[oracle docs images](https://docs.oracle.com/en-us/iaas/images/)