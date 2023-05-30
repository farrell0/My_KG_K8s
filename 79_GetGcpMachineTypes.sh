#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Output GCP machine types for your chosen REGION/ZONE:"
echo ""
echo "   (working ..)"


########################################################################


gcloud compute machine-types list | egrep "${GCP_ZONE}|^NAME" > /tmp/${MY_USERNAME}.${$}.tmp
   #
cat /tmp/${MY_USERNAME}.${$}.tmp | grep -v "^NAME" | cut -d' ' -f1 | sed 's/-[^-]*//2g' | sort | uniq  

echo ""
read -e -p "Enter the major machine type you wish to work with (default, n2-highmem): " l_version
echo ""

[ -z ${l_version} ] && {
   l_version="n2-highmem"
}

cat /tmp/${MY_USERNAME}.${$}.tmp | egrep "^NAME|${l_version}" 
   #
rm -f /tmp/${MY_USERNAME}.${$}.tmp

echo ""
echo ""






