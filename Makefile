deploy:
	bash make.sh upgrade || bash make.sh install

create-secrets:
	bash make.sh create-secrets

print-dda-interface-secret:
	kubectl get secret dda-interface-token -n staging-1-3 -o json | jq -r '.data["token.txt"]' | base64 -d
