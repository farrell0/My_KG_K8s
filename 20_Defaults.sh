#!/bin/bash


#
#  This file is sourced from most programs in this folder;
#  variables used throughout.
#

alias kc=kubectl


##############################################################
##############################################################


#  Our local/personal values, used to generate even more given
#  values below.
#

#  If you work at Katana Graph, use the leading portion of your
#  email address.
#
#  .  These settings are used to derive other setting below.
#  .  This pair is also your username/password to log into
#     Jupyter.
#
export MY_USERNAME=farrell
export MY_PASSWORD=farrell_XXXXXXXXXXX

   
#  A GKE cluster has its own software version. This is the version
#  we use.
#
#  gcloud container get-server-config --flatten="channels" --filter="channels.channel=RAPID" --format="yaml(channels.channel,channels.validVersions)" --zone ${GCP_ZONE}
#
#  export MY_GKE_CLUSTER_VERSION="1.22.17-gke.3100"
export MY_GKE_CLUSTER_VERSION="1.22.17-gke.6100"


#  Derived values.
#
#  .  Inside GKE, we create a namespace, and place all of our
#     GKE objects there. This is the name of that namespace.
#  .  The name of our KatanaGraph cluster.
#
export MY_NAMESPACE=namespace-${MY_USERNAME}
export MY_KG_CLUSTER_NAME=kg-cluster-${MY_USERNAME}


#  The Katana documentation had reference to two variables,
#
#     KATANA_CONTROL_VM_TYPE
#     KATANA_WORKER_VM_TYPE
#
#  These variables are used to specify the [ machine types ] for
#  the Katana Graph administrative activities (CONTROL), and
#  then workers.
#
#  These new variables below are used to specify the [ count ] of
#  these types of machines.
#
#     (Given all we ask for elsewhere, a worker count of at least
#      4 should be considered minimum.)
#
export MY_KATANA_CONTROL_VM_TYPE_COUNT=3
export MY_KATANA_WORKER_VM_TYPE_COUNT=4            


#  GitHub access token; Currently needed to clone KG helm charts,
#  as they are in a private GitHub repo-
#
#  How to get a GitHub access token,
#     https://github.com/settings/tokens
#
export MY_GH_AUTH_TOKEN=ghp_KHIqcsNNoXXXXXXXXXXXXXXXXXXNuRodKc7f3DuXgn


##############################################################
##############################################################


#  What to set these to ?
#     https://docs.k9h.dev/latest/docs/install-k8s/prerequisites.html


#  The Katana doc used to call this variable, GCP_PROJECT_ID,
#  and used it as the GCP PROJECT NAME.
#
#  There is an actual ID to a GCP PROJECT, a numeric, that we
#  need. And there is an actual NAME.
#
#  So, we use NAME.
#
export GCP_PROJECT_NAME=katana-cd6


#  Get the actual ID
#
#  Data we are working with looks like,
#     gcloud projects list --format=json | jq -c ".[] | select( .name == ${GCP_PROJECT_ID} )"
#
#     {"createTime":"2021-10-05T02:59:25.241Z","lifecycleState":"ACTIVE","name":"katana-cd6",
#      "parent":{"id":"173080283030","type":"folder"},"projectId":"katana-cd6","projectNumber":"799544334556"}
#
export GCP_PROJECT_ID=`gcloud projects list --format=json | jq -c -r '.[] | select( .name == '\"${GCP_PROJECT_NAME}\"' ) | .projectNumber'`


#  Url to bucket-farrell  in katana-cs6
#
#   https://console.cloud.google.com/storage/browser/bucket-farrell


#  All of these are required.
#
export GCP_REGION=us-central1
export GCP_ZONE=us-central1-c
   #
export GCS_BUCKET=gs://bucket-${MY_USERNAME}

#  Service accounts-
#
#  .  Service accounts are like user names, but for daemons.
#  .  A GCP project will have a default service account.
#  .  We will need to link the GCP service account to other,
#     lesser, embedded service accounts we use for GKE, and/or
#     Katana Graph.
#
export GCP_SERVICE_ACCOUNT=${GCP_PROJECT_ID}-compute@developer.gserviceaccount.com
export KATANA_SERVICE_ACCOUNT_NAME=katana-sa-${MY_USERNAME}

   
#  The name of our GKE cluster.
#
#  .  We made chose to give each person their own GKE cluster,
#     or share a clsuter. That's a policy decision.
#  .  "se" is short for "software engineers".
#
#  export GKE_CLUSTER_NAME=kg-cluster-se
export GKE_CLUSTER_NAME=kg-cluster-${MY_USERNAME}


#  The machine type for our Katana Graph pods.
#  
#  .  We divide these into administrative, low end boxes,
#     (CONTROL), and presumably a more performant box for
#     (WORKER).
#
export KATANA_CONTROL_VM_TYPE=e2-standard-8
export KATANA_WORKER_VM_TYPE=n2-highmem-32
# export KATANA_WORKER_VM_TYPE=n2-highmem-64


##############################################################


#  Within Katana Graph, we use GCS storage buckets to read from
#  a number of standard data sets. Regardless of whether you can
#  read these from your personal account, your KGIP cluster is
#  operating with a different (service account). 
#
#  We need this KGIP operating service account to be granted access
#  to the standard data set GCS storage bucket.
#
#  What is the service account name we wish to link to ?
#
KATANA_PRODUCT_SANDBOX_SERVICE_ACCOUNT="kgacc701c4824851eeb854530b09ea@cc-infra-53a7.iam.gserviceaccount.com"

#  How did we know the above location and such; we were told.


##############################################################
##############################################################


#  Getting the Katana version (currently internal, private). 
#  In effect, what version of Katana graph to run,
#
#     gsutil ls gs://a62ce480-artifacts/versions
#        ^^^^ pick a version from above
#
#     gsutil ls gs://a62ce480-artifacts/versions/0.8.0+20230217T153604Z.7a9728906.dev
#        gs://a62ce480-artifacts/versions/0.8.0+20230217T153604Z.7a9728906.dev/katana-conda.tar.gz
#        gs://a62ce480-artifacts/versions/0.8.0+20230217T153604Z.7a9728906.dev/katana-deploy.tar.gz
#        gs://a62ce480-artifacts/versions/0.8.0+20230217T153604Z.7a9728906.dev/katana-hub.tar.gz
#        gs://a62ce480-artifacts/versions/0.8.0+20230217T153604Z.7a9728906.dev/katana-notebook.tar.gz
#
#           ^^^^ you want a listing that has a "katana-notebook.tar.gz"
#

#  Past versions,
#
#     0.6.0+20221213T053830Z.8707c4b0a
#     0.8.0+20230217T153604Z.7a9728906.dev
#     0.8.0_20230221T201541Z.03e2372a6.dev                          <--  Used this for a bit
#     0.8.0+20230301T170702Z.5ee413de9.dev                          <--  Current
#


#  Note:  These do not have a trailing slash
#
#  export KATANA_VERSION="0.8.0+20230301T170702Z.5ee413de9.dev"
#  export KATANA_VERSION="0.9.0+20230315T145956Z.dbe1b6788"
#  export KATANA_VERSION="0.9.0+20230322T224759Z.73f024927"
#  export KATANA_VERSION="0.10.0+20230404T232800Z.83b2c54e1.dev"
export KATANA_VERSION="0.10.0+20230418T214403Z.fe6fdcf83"


#    ^^^^  Above: you'll need a version of this without a plus symbol.
#             Change the plus to an underscsore.
#
export KATANA_VERSION_FIXED=`echo ${KATANA_VERSION} | sed 's/+/_/g'`


##############################################################
##############################################################


#  It's overkill to do this each time but it's low cost (super fast)
#
gcloud config set project ${GCP_PROJECT}             2> /dev/null








