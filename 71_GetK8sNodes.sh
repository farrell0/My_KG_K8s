#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "GKE Nodes list:"
echo ""

gcloud container node-pools list --cluster ${GKE_CLUSTER_NAME} --region ${GCP_REGION}

echo ""

kubectl get nodes -A

echo ""
echo ""

