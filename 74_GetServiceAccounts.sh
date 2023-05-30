#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""


echo "Get GCP service account list:"
gcloud iam service-accounts list
echo ""


echo "Get GKE service account list:  (minus kube-system)"
kubectl get serviceaccounts -A | grep -v kube-system
echo ""


echo ""
echo ""




