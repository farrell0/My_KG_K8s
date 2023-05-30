#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Get GCP/GKE Supported Kubernetes versions:"
echo ""

gcloud container get-server-config --zone ${GCP_ZONE} --format "yaml(channels)"

echo ""
echo ""


