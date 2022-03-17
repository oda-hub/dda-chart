export ODA_NAMESPACE=${ODA_NAMESPACE:-oda-staging}

function create-secrets(){
     set -x

     echo -e "\033[33mcreating secrets for dda in ${ODA_NAMESPACE}\033[0m"

     kubectl -n $ODA_NAMESPACE delete secret dda-interface-token || echo ok
     kubectl -n $ODA_NAMESPACE create secret generic dda-interface-token  --from-file=./private/token.txt
}

function install() {
    upgrade
}

function upgrade() {
    set -x
    helm upgrade --install -n ${ODA_NAMESPACE:?} oda-dda . \
        -f values-${ODA_SITE}.yaml \
        --set image.tag="$(cd dda; git describe --always)" 
#        --set securityContext.runAsUser=5182 
#        --set securityContext.runAsGroup=4700
        #--set image.tag=6388fb4 \
        #--set securityContext.runAsGroup=4915
}

$@
