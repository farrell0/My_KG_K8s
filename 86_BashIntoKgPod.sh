#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Calling 'kubectl' to Bash into Katana Graph nodes (pods) ..."
echo ""
echo "   (Be advised: raw terminal mode does not work, works poorly.)"
echo ""
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
sleep 10


l_cntr=0

for l_node in `kubectl get pods -n ${MY_NAMESPACE} -o json | jq -r '.items[].metadata.name'`
   do

   l_cntr=$((l_cntr+1))
      #
   echo "  ${l_cntr}:  ${l_node}"
   done

echo ""
echo ""
echo -n "Enter the node number to Bash into: "
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

      kubectl -n ${MY_NAMESPACE} exec --stdin --tty ${l_node} -- /bin/bash

   } || {
      :
   }
   done

echo ""
echo ""



