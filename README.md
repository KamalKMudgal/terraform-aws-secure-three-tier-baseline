# Secure AWS Three-Tier Baseline

## What

Terraform for an AWS baseline: a VPC with public ingress and private application/data subnets, tier security groups, and an encrypted private S3 bucket.

## Why

Private subnets reduce direct internet exposure; security-group references permit only intended tier-to-tier traffic; S3 blocks public access, encrypts at rest, versions objects, and denies non-TLS access.

## How

```sh
terraform init
terraform fmt -check
terraform validate
terraform plan
```

Use short-lived AWS credentials outside the repository. This baseline deliberately does not create NAT gateways or compute instances; add workload components only after reviewing cost and egress requirements.

## Verification

Confirm no public IPs in private subnets, S3 Block Public Access/encryption enabled, and passing Checkov/Trivy CI output. Review every Terraform plan before apply.
