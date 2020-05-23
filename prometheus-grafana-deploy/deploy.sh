sudo apt update -y
sudo apt install nfs-kernel-server -y
sudo mkdir /srv/nfs/kubedata -p
sudo cp exports /etc/exports
kubectl config set-context --current --namespace default
kubectl create -f class.yaml -f deployment.yaml -f rbac.yaml
helm install stable/prometheus --name prometheus --values ./prometheus.values --namespace prometheus
helm install stable/grafana --name grafana --values ./grafana.values --namespace grafana
echo "Deploying... Please wait a minute"

sleep 35

kubectl get all -n prometheus
kubectl get all -n grafana

echo "Access grafana over <master-ip>:32323"
echo "Access Prometheus over <master-ip>:32322"
