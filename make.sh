export ODA_NAMESPACE=${ODA_NAMESPACE:-staging-1-3}

function create-secrets(){
     set -x

     echo -e "\033[33mcreating secrets for dda in $ODA_NAMESPACE\033[0m"

     kubectl -n $ODA_NAMESPACE delete secret dda-interface-token || echo ok
     kubectl -n $ODA_NAMESPACE create secret generic dda-interface-token  --from-file=./private/token.txt

#    kubectl create secret generic odatests-tests-bot-password  --from-file=./private/testbot-password.txt
#    kubectl create secret generic odatests-secret-key  --from-file=./private/secret-key.txt
#    kubectl create secret generic minio-key  --from-file=./private/minio-key.txt
#    kubectl create secret generic jena-password  --from-file=./private/jena-password.txt
#    kubectl create secret generic logstash-entrypoint  --from-file=./private/logstash-entrypoint.txt
}

function install() {
    upgrade
}

function upgrade() {
    set -x
    helm upgrade --install -n ${ODA_NAMESPACE:?} dda . \
        --set image.tag="$(cat dda/image-tag)" \
        --set securityContext.runAsUser=5182 \
        --set securityContext.runAsGroup=4700
}

$@
