#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Step 1 of 1: Calling 'helm' to delete Katana Graph Intelligence"
echo "   Platform (KGIP) cluster ..."
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo "       (This command takes 4+ minutes to complete.)"
echo ""
sleep 10

cd ./B1_KatanaHelmCharts/katana-chart/chart/katana
   #
helm delete ${MY_KG_CLUSTER_NAME} -n ${MY_NAMESPACE}

#  The Jupyter Notebook pod is/was not deleteing properly above.
#  Delete it manually,    (yes, this is a hack, work around) 
#
kubectl -n ${MY_NAMESPACE} delete pod kg-cluster-${MY_USERNAME}-katana-notebook-${MY_USERNAME}

cd ../../../../


##############################################################


echo ""
echo ""






