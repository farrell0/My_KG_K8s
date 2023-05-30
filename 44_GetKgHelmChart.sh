#!/bin/bash


#  . "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "(Many steps): Calling 'git clone' to download the Katana Graph"
echo "   Intelligence Platform (KGIP) Helm Charts, and other/small"
echo "   related work."
echo ""
echo "   (Assets that allow you to run KGIP atop K8s.)"
echo ""
echo "   .  This program does occasionally prompt you to further authenticate"
echo "      against GitHub. If prompted, please complete those steps."
echo ""
echo "   .  You only need to run this program one time, or then when changing"
echo "      your KGIP charts version."
echo ""
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
sleep 10


#  See,
#     https://devops.pingidentity.com/how-to/privateRepos/
#     https://github.com/settings/tokens

#  We want the 0.5 version of this GH repository,
#
#     https://github.com/KatanaGraph/katana-chart.git
#     https://github.com/KatanaGraph/katana-chart/tags
#        katana-v0.5.0
#
l_chartrepo=https://github.com/KatanaGraph/katana-chart.git
l_chartversion=katana-v0.5.0
   #
l_folderweseek=B1_KatanaHelmCharts


###############################################################


#  For testing,
#     gh auth logout
#     gh auth login 
#
echo ${MY_GH_AUTH_TOKEN} | gh auth login --with-token
   #
[ -d ${l_folderweseek} ] && {

   echo ""
   echo "Step 1: Clone the Katana Graph Helm chart repository .."
   echo ""
   cd ${l_folderweseek}
      #
   l_whichdir=`pwd`
   l_whichdirbase=`basename "${l_whichdir}"`
      #
   rm -rf *                                                                   #  Agreed; this is bad form
      #
   #  For the current versions of this repo use,
   #
   #  gh repo clone ${l_chartrepo}
   #
   #  For version 0.5, we located the branch, and use,
   #
   git clone  ${l_chartrepo} --branch ${l_chartversion}
      #
   cp ./katana-chart/chart/katana/values.yaml  ./katana-chart/chart/katana/values.yaml.orig
      #
   echo ""

      ###

   #  Do the Helm repositories now ..
   #
   echo ""
   echo "Step 2: Adding reference to Helm repositories .."
      #
   helm repo add bitnami https://charts.bitnami.com/bitnami
   helm repo add hashicorp https://helm.releases.hashicorp.com
   helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
   helm repo update
   echo ""

   #  Do the required 'helm build' step
   #
   echo ""
   echo "Step 3:  Do the required 'helm build' step .."
   echo ""
      #
   cd ./katana-chart
      #
   helm dependency build chart/katana
      #
   cd ../..

} || {

   echo ""
   echo "Error:  this program expects to see a subfolder titled, \"${l_folderweseek}\""
   echo "   and this folder is not present."
   echo ""
   echo "   Program stopping."
   echo ""
   exit 3

}


###############################################################


echo ""
echo ""
echo "Next steps:"
echo ""
echo "   .  You have the Katana Graph Intelligence Platform helm charts."
echo "      Now view/run file 45* to personalize file B8* to your specific"
echo "      needs."
echo ""
echo ""










