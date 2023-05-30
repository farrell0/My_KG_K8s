#!/bin/bash


. ./20_Defaults.sh


##############################################################


echo ""
echo ""
echo "Calling 'kubectl' to 'df -k' into Katana Graph nodes ..."
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
sleep 10


##############################################################


#  Raw data per pod looks like,
#
#     Filesystem     1K-blocks    Used Available Use% Mounted on
#     overlay        511701244 3141592 508543268   1% /
#     tmpfs              65536       0     65536   0% /dev
#     tmpfs           16441380       0  16441380   0% /sys/fs/cgroup
#     /dev/sda1      511701244 3141592 508543268   1% /etc/hosts
#     /dev/sdb          996780     148    980248   1% /srv/jupyterhub
#     shm                65536       0     65536   0% /dev/shm
#     tmpfs           29087816      12  29087804   1% /run/secrets/kubernetes.io/serviceaccount
#     tmpfs           29087816      28  29087788   1% /usr/local/etc/jupyterhub/secret
#     tmpfs           16441380       0  16441380   0% /proc/acpi
#     tmpfs           16441380       0  16441380   0% /proc/scsi
#     tmpfs           16441380       0  16441380   0% /sys/firmware


echo "KatanaGraph-Node/K8s-Pod                                    Filesystem          Size-GB     Used-GB     Available   Use%  Mounted on"
echo "==========================================================  ==================  ==========  ==========  ==========  ====  ===================="


#  This was not working, should have worked
#
#  kubectl get pods -n ${MY_NAMESPACE} -o=jsonpath='{.items.metadata.name}'
#

for l_node in `kubectl get pods -n ${MY_NAMESPACE} -o json | jq -r '.items[].metadata.name'`
   do

   kubectl -n ${MY_NAMESPACE} exec ${l_node} -- df 2> /dev/null | egrep "overlay|sda1|sbd" | awk -v l_node=${l_node} '
      {
      printf("%-58s  %-18s  %-10.2f  %-10.2f  %-10.2f  %4s  %s\n", l_node, $1, $2/1024/1024, $3/1024/1024, $4/1024/1024, $5, $6);
      }'
   echo ""

   done


echo ""
echo ""




