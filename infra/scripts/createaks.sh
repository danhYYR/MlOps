source ../venv/az.env
az aks create --resource-group $GRPNAME --name $AKSNAME --node-count 2
az aks get-credentials --resource-group $GRPNAME --name $AKSNAME