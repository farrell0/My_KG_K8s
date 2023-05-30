#!/usr/bin/bash


#  This is a personal script I use to push GitHub changes.
#
#  Inside the Jupyter container, I run this script to push changes
#  up to my GitHub repo.
#
#  You do not need this script.
#


MY_GH_USERNAME=farrell0
MY_GH_NB_REPO=My_KG_NoteBooks
MY_GH_AUTH_TOKEN=ghp_w2JfXXXXXXXX1uB255U6u


#########################################################


pip install --upgrade jupyterlab-vim

   ###

git config --global --add safe.directory /home/jovyan/${MY_GH_NB_REPO}

git config --global user.email "Push.sh@example.com"
git config --global user.name "Push.sh Name"


cd /home/jovyan/${MY_GH_NB_REPO}
   #
while true
   do
   date
   git add .
   git commit -m 'No message'
   git push https://${MY_GH_AUTH_TOKEN}@github.com/${MY_GH_USERNAME}/${MY_GH_NB_REPO}.git
   echo '###############################'
   echo ''
      #
   sleep 60
   done





