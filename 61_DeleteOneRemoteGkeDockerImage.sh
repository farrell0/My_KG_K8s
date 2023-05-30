#!/bin/bash


. "./20_Defaults.sh"


##############################################################


#  See,
#     https://cloud.google.com/container-registry/docs/managing#gcloud
#

echo ""
echo ""
echo "Step 1 of 1: Delete remote GKE repository container image .."
echo ""
echo "   ** You may receive an optional prompt to (re)authenticate against gcloud."
echo "      (In which case, a browser window will open.)"
echo ""
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""

sleep 10


./82_GetRemoteGkeDockerImages.sh

echo "Enter the full  DIGEST  value of the image to delete .."
echo "   For example;  sha256:7368ee6221e475a0c6bb136b643d1cd181aa756a2b5c58084c68a7620c933b99"
echo ""
read -e -p "   Enter here:   " l_digest


#  This is kind of hacky; we run this command twice-
#
l_todelete=`./82_GetRemoteGkeDockerImages.sh | grep ${l_digest} | awk '{print $1}'`
   #
echo ""
gcloud -q container images delete ${l_todelete}@${l_digest} --force-delete-tags
echo ""

./82_GetRemoteGkeDockerImages.sh

echo ""
echo ""



