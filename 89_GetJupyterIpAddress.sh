#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Get IP address for Jupyter Notebook .."
echo ""

l_address=`kubectl get service proxy-public -n ${MY_NAMESPACE} -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'`

while true
   do

   [ -z ${l_address} ] && {
      echo "   waiting for IP address to arrive .."
      l_address=`kubectl get service proxy-public -n ${MY_NAMESPACE} -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'`
      sleep 5
   } || {
      break
   }

   done

echo ""
echo "IP address to access Jupyter Notebook is:"
echo ""
echo "   http://${l_address}"
echo "      username: ${MY_USERNAME}"
echo "      password: ${MY_PASSWORD}"

echo ""
echo "Fyi:  On any first anything, load times can take a bit, minutes even."


echo ""
echo ""


