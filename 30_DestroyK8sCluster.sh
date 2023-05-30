#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Step 1 of 1: Calling 'gcloud' to delete K8s cluster .."
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
sleep 10


#  Yes, that seems to confuse ZONE and REGION below-
#
#  Doesn't work otherwise-
#
gcloud container clusters delete -q ${GKE_CLUSTER_NAME} --zone ${GCP_REGION} --project ${GCP_PROJECT_NAME}


echo ""
echo ""




