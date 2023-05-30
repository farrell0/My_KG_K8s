#!/bin/bash



#  **  This command and the format of its output is relied upon
#      by other files in this folder.
#      

. "./20_Defaults.sh"


##############################################################


echo ""
echo ""


#  See,
#     https://cloud.google.com/container-registry/docs/managing#gcloud
#
echo "Get remote GKE container repository images .."
echo ""

#  gcloud container images list --repository=us.gcr.io/${GCP_PROJECT_NAME}
#  gcloud container images list --repository=gcr.io/${GCP_PROJECT_NAME}

echo "NAME                                       TAGS                                           DIGEST"
echo "========================================   ============================================   ========================================================="
   #
for l_each in `gcloud container images list --repository=gcr.io/${GCP_PROJECT_NAME} | grep -v NAME`
   do
   gcloud container images list-tags --format='get(tags, digest)' ${l_each} | \
   while read l_line
      do
      l_tag=$(echo ${l_line} | awk '{print $1}')
      l_digest=$(echo ${l_line} | awk '{print $2}')
         #
      printf "%-40s   %-44s   %s\n" ${l_each} ${l_tag} ${l_digest}
      done 
   done


echo ""
echo ""




