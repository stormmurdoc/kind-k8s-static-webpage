#!/usr/bin/env sh

RESULT=$(kind get clusters)
SVC_NAME=nginx-service

if [ -z "$RESULT" ];then
    echo "Starting KinD cluster..."
    kind create cluster --config kind.yaml
else
    echo "cluster '$RESULT' found!"
fi

echo "+++ build docker image +++"
docker build . -t blog:0.1.0

echo "+++ loading docker image into kind +++"
kind load docker-image blog:0.1.0

#kind delete cluster
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml

echo "+++ waiting 15 seconds +++"
sleep 15
NODE_IP=$(kubectl get node -o wide|tail -1|awk {'print $6'})
NODE_PORT=$(kubectl get svc "$SVC_NAME" -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')
echo "http://$NODE_IP:$NODE_PORT"
RESULT=$(curl $NODE_IP:$NODE_PORT)
echo "------------------------------------------------------------------------"
echo "$RESULT"
echo "------------------------------------------------------------------------"
