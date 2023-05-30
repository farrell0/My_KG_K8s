#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Step 1 of 1: Delete all local Docker images .."
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
sleep 10


echo "Delete Docker Images (Stopped) .."
for t in `docker ps --filter "status=exited" --format '{{.ID}}'`
   do
   docker rm $t      # --force
   done
echo ""
echo "Delete Docker Images (in local repository) .."
for t in `docker image ls --format '{{.ID}}'  `
   do
   docker rmi $t --force
   done


echo ""
echo ""


