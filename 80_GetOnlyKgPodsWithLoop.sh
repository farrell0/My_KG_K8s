#!/bin/bash


. "./20_Defaults.sh"


echo ""
echo ""
echo "Press CONTROL-C to quit ..."
echo ""
echo "   (Reporting only pods from the \"${MY_NAMESPACE}\" namespace.)"
echo ""
echo ""

watch kubectl get pods -n ${MY_NAMESPACE} 

echo ""
echo ""

