#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Get PV listing:"
echo ""
kubectl -n ${MY_NAMESPACE} get pv

echo ""
echo "Get PVC listing:"
echo ""
kubectl -n ${MY_NAMESPACE} get pvc

echo ""
echo ""


