#!/bin/bash


. "./20_Defaults.sh"


##############################################################


#  What we really want is,
#
#     kubectl describe nodes -o json
#
#  but the 'describes' are human readable, not available in json.
#
#  So we Awk. Data we want looks like,
#
#       Namespace                   Name                                                            CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
#       ---------                   ----                                                            ------------  ----------  ---------------  -------------  ---
#       kube-system                 fluentbit-gke-mf5gx                                             100m (1%)     0 (0%)      200Mi (0%)       500Mi (1%)     43m
#
#       kube-system                 fluentbit-gke-mf5gx                                             100m (1%)     0 (0%)      200Mi (0%)       500Mi (1%)     43m

echo ""
echo ""
echo "Get Kubernetes nodes/pods, detailed listing:"
echo ""


kubectl describe nodes | awk -v l_namespace=${MY_NAMESPACE} '
   {
   if ($1 == "Name:" ) {
      print("")
      printf("K8s Node name: %s\n", $2)
      print("  K8s Pod name                                                      CPU Requests  CPU Limits    Mem Requests        Mem Limits          Age")
      print("  ----------------------------------------------------------------  ------------  ------------  ------------------  ------------------  ---")
      }
   else if ($1 == l_namespace) {
      printf("  %-64s   %-5s %-5s   %-5s %-5s   %-10s %-6s   %-10s %-6s  %-3s\n", $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
      }
   }
   '


echo ""
echo ""


