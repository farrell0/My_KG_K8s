#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "This program gets Kubernetes logs from a given Katana Graph node (1-N)."
echo ""
echo "(Similar to a 'tail -f', press Control-C to terminate output.)"
echo ""
echo ""


l_cntr=0
   #
for l_node in `kubectl get pods -n ${MY_NAMESPACE} -o json | jq -r '.items[].metadata.name'`
   do

   l_cntr=$((l_cntr+1))
      #
   echo "  ${l_cntr}:  ${l_node}"
   done

echo ""
echo ""
echo -n "Enter the node number to get Kubernetes logs from: "
   #
read l_numb
   #
[ -z ${l_numb} ] && {
   l_numb=0
}


##############################################################


l_cntr=0

for l_node in `kubectl get pods -n ${MY_NAMESPACE} -o json | jq -r '.items[].metadata.name'`
   do
   l_cntr=$((l_cntr+1))
      #
   [ ${l_cntr} -eq ${l_numb} ] && {

      kubectl logs -f --namespace=${MY_NAMESPACE} ${l_node}     #  -c server-system-logger

   } || {
      :
   }
   done

echo ""
echo ""



