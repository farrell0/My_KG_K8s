#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Step 1 of 1: Calling 'helm' to create Katana Graph Intelligence"
echo "   Platform (KGIP) cluster ..."
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo "       (This command takes 4+ minutes to complete.)"
echo "       (Be advised; Some pods may Crash/Restart before actually coming up.)"
echo ""
sleep 10

cd ./B1_KatanaHelmCharts/katana-chart/chart/katana
   #
helm install ${MY_KG_CLUSTER_NAME} . -f values_override.yaml -n ${MY_NAMESPACE}
   #
cd ../../../../


##############################################################


echo ""
echo ""
echo "Next steps:"
echo ""
echo "   .  Watch the KGIP pods come up,"
echo ""
echo "         kubectl get pods -n ${MY_NAMESPACE}"
echo "         watch kubectl get pods -n ${MY_NAMESPACE}"
echo ""
echo "   .  Open a Web browser to the [ EXERNAL IP address ] address for Jupyter .."
echo ""
echo "      Sample value:  https://99.99.99.99"
echo "         username:  ${MY_USERNAME}"
echo "         password:  ${MY_PASSWORD}"
echo ""
echo "      Running file 89* outputs this address."

echo ""
echo ""






