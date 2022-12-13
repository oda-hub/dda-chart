deploy:
	bash make.sh upgrade # || bash make.sh install

create-secrets:
	bash make.sh create-secrets

print-dda-interface-secret:
	kubectl get secret dda-interface-token -n staging-1-3 -o json | jq -r '.data["token.txt"]' | base64 -d


metrics-prep:
	helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
	helm repo update

metrics:
	helm upgrade --install oda-prometheus prometheus-community/prometheus-adapter # --set --prometheus-url prometheus-server

prometheus:
	helm install prometheus stable/prometheus
