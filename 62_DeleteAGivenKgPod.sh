#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Calling 'kubectl' to destroy a Katana Graph node (pod) ..."
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
sleep 10


l_cntr=0
   #
echo "   NUMBER  NAME                                                   READY STATUS     RESTARTS      AGE"

kubectl -n ${MY_NAMESPACE} get pods --no-headers | \
   while read l_line
      do
      l_cntr=$((l_cntr+1))
         #
      printf "   %2d.)    %-s   %-32s\n" ${l_cntr} "${l_line}"
      done


echo ""
echo ""
echo -n "Enter the pod number to destroy: "
   #
read l_numb
   #
[ -z ${l_numb} ] && {
   l_numb=0
}


##############################################################


l_cntr=0


kubectl -n ${MY_NAMESPACE} get pods --no-headers | \
   while read l_line
      do
      l_cntr=$((l_cntr+1))
         #
      [ ${l_cntr} -eq ${l_numb} ] && {

         l_name=$(echo ${l_line} | cut -d " " -f 1      )
         kubectl -n ${MY_NAMESPACE} delete pod ${l_name}

      } || {
         :
      }
      done


echo ""
echo ""



