#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "GKE clusters list for project: "${GCP_PROJECT}
echo ""

gcloud container clusters list

echo ""
echo ""


