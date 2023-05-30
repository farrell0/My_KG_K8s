#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "(Many steps): Identifying a Katana Graph product version number,"
echo "   putting the Docker images where they need to be."
echo ""
echo "   .  Because of file download/upload sizes, this command takes"
echo "      a bit of time to run."
echo "   .  Before running this command, you are expected to have the"
echo "      K8s cluster with all Katana Graph required entities present."
echo "      (Storage buckets, service accounts, etc.)"
echo ""
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
#  sleep 10


########################################################################


#  Data arrives as,
#     0.4.0+20220811T175238Z.f0f551901.dev/
#     0.4.0+20220815T194254Z.5c5b0c0f6.dev/
#     0.4.0+20220816T175812Z.10f2009a0.dev/
#     0.4.1+20221216T221234Z.5cb5b7c0d.dev/
#     0.4.1+20221229T173500Z.706f5e972.dev/
#
echo ""
echo "Available Katana Graph major version numbers:"
echo ""
gsutil ls gs://a62ce480-artifacts/versions | sed 's/gs:\/\/a62ce480-artifacts\/versions\///g' | \
   sed 's/\+.*$//' | grep -v "^pr" | sort -V | uniq
echo ""
read -e -p "Enter the major version number you wish to work with: " l_version
echo ""





echo ""
echo ""
echo "** If you are pasting in your own generated version number below,"
echo "     .  Of course, this version may not be found."
echo "     .  Notice the plus symbol."
echo "     .  Notice the trailing slash."
echo ""
echo "   These are required."
echo ""
echo "Last 20 builds in this major number:"
echo ""
gsutil ls gs://a62ce480-artifacts/versions | sed 's/gs:\/\/a62ce480-artifacts\/versions\///g' | \
   grep "^${l_version}" | tail -20

echo ""
read -e -p "Enter the full version number to download (full value exactly as shown): " l_version
echo ""

#  The version number has a plus sign in it, which will fail
#  later, and a trailing slash; remove/change those.
#
l_version_clean=`echo ${l_version} | sed 's/+/_/' | sed s'/\/$//'`


########################################################################


l_folder=./C1_KatanaContainerImages/${l_version}
mkdir -p ${l_folder}

echo "Step 1: Downloading .."
echo "   ** Big file; this takes a bit of time."
echo "   ** If you get an error here, most likely this was a \"doc\" build only,"
echo "      without any actual software. You must choose another version."
echo ""
   #
[ -f ${l_folder}katana-notebook.tar.gz ] && {
   echo ""
   echo "Note:  Container image already present on local hard disk, already downloaded."
   echo "       So, we'll skip this step."
} || {
   gsutil -m cp -r gs://a62ce480-artifacts/versions/${l_version}katana-notebook.tar.gz  ${l_folder}    #  There was already a trailing slash in $l_version
}
echo ""


echo ""
echo "Step 2:  Load this container image into the local Docker (enables Docker pushes to the GKE container repository) .."
echo "         (Sorry; there is no initial out of the box progress bar here. Be patient.)"
echo ""
docker load < ${l_folder}katana-notebook.tar.gz                                                        #  There was already a trailing slash in $l_version
echo ""


echo ""
echo "Step 3:  (Read only; view the local Docker repository.)"
echo ""
docker image ls
echo ""


echo ""
echo "Step 4:  Docker 'tag' this image  (add metadata we need)"
echo ""
docker tag "kgcr.io/katana-enterprise/katana-notebook:${l_version_clean}" "gcr.io/${GCP_PROJECT_NAME}/katana-notebook:${l_version_clean}"
echo ""


echo ""
echo "Step 5:  (Read only; view the local Docker repository.)"
echo ""
docker image ls
echo ""


#  See,   (console only option)
#     https://cloud.google.com/sdk/docs/authorizing
#

echo ""
echo "Step 6:  Push this container image up to our GKE container repository .."
echo "   (An upload, this command takes a bit of time.)"
echo ""
echo "   ** You may receive an optional prompt to (re)authenticate against gcloud."
echo "      (In which case, a browser window will open.)"
echo ""
echo ""
   #
gcloud auth application-default login    #  --console-only
gcloud -q auth configure-docker
echo ""
   #
docker push gcr.io/${GCP_PROJECT_NAME}/katana-notebook:${l_version_clean}
echo ""


#  See,
#     https://cloud.google.com/container-registry/docs/managing#gcloud
#
echo ""
echo "Step 7:  (Read only; view the remote GKE container repository.)"
echo ""
#  gcloud container images list --repository=us.gcr.io/${GCP_PROJECT_NAME}
#  gcloud container images list --repository=gcr.io/${GCP_PROJECT_NAME}

./82_GetRemoteGkeDockerImages.sh


########################################################################

echo ""
echo ""
echo "Next steps:"
echo ""
echo "   Run file(s) 44* or 45* to manage your helm charts prior"
echo "   to calling to create an actual Katana Graph Intelligence"
echo "   Platform cluster."
echo ""
echo "     .  File 44* downloads/installs the helm chart package."
echo ""
echo "     .  File 45* 'personalizes' the [values_overrides.yaml];"
echo "        basically supply specific values you need/want like,"
echo "        machine type, number of nodes, other."

echo ""
echo ""






