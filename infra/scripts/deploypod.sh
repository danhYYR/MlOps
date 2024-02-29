# Create Namespace
kubectl create -f ../aks-define/namespace_k8s.yaml
# Create ConfigMap
kubectl create -f ../aks-define/envars_k8s.yaml
kubectl create -f ../aks-define/envars-credential_k8s.yaml
# Deploy POD
kubectl create -f ../aks-define/webapp-pod_k8s.yaml
kubectl create -f ../aks-define/db-pod_k8s.yaml
# Deploy Service
kubectl create -f ../aks-define/webapp-svc_k8s.yaml
kubectl create -f ../aks-define/db-svc_k8s.yaml