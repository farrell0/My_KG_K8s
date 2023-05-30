#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""


echo "Get local (STOPPED) Docker images:"
docker ps --filter "status=exited" 
echo ""


echo "Get local (all other) Docker images:"
docker image ls 
echo ""


echo ""
echo ""


##############################################################
##############################################################


#  From COD (useful),
#
#     docker container ls
#
#     CONTAINER ID   IMAGE                                      COMMAND                  CREATED          STATUS          PORTS                                       NAMES
#     532eb644f6be   gcr.io/katana-internal39/katana-notebook   "tini -g -- start-no…"   13 minutes ago   Up 13 minutes   0.0.0.0:8888->8888/tcp, :::8888->8888/tcp   fervent_driscoll
#
#     docker ps --format '{{.Names}}'
#     fervent_driscoll
#
#     l_node=`docker ps --format '{{.Names}}' | head -1`
#        #
#     [ -z ${l_node} ] && {
#        echo ""
#        echo "ERROR:  No KG Client VM running/found ..."
#        echo ""
#        echo ""
#        exit 2
#        }
#
#     docker cp $1 container_id:/$1
#
#     docker exec -it -u 0 ${l_node} bash






