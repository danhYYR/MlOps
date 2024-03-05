terraform apply \
    -var-file tfvars/dev.tfvars \
    -var tenant_id=$TENANT_ID  \
    -var sp_id=$SP_ID \
    -var sp_secret=$SP_SECRET \
    -var-file tfvars/sh.tfvars \
    -auto-approve 