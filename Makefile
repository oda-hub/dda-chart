deploy:
	bash make.sh upgrade || bash make.sh install

create-secrets:
	bash make.sh create-secrets
