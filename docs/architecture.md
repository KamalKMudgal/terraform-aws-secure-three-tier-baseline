# Architecture

```mermaid
flowchart TB
  Internet --> Edge[Public ingress tier]
  Edge --> App[Private application subnet]
  App --> Data[Private data subnet]
  App --> Bucket[Private encrypted S3 bucket]
```

The application and data tiers receive no public IPs. The ingress tier is a conceptual boundary for a future load balancer or WAF; it is not provisioned by this cost-conscious baseline.
