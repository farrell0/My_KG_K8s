

   Introduction
   ------------------------------------------------------

   This file is version:  0.8.003

   This folder contains a number of Bash shell scripts used to
   aid your deployment of a Katana Graph Intelligence Platform
   (KGIP) atop a Kubernetes cluster.

      Effectively, this folder contains scripts that aid you in
      implementing the tasks outlined at,

         https://docs.k9h.dev/latest/docs/install-k8s/index.html

   This document is organized into the following sections;

      .  Required Software
      .  Required Permissions/Access
      .  How to use the (defaults) file
      .  Operating the programs in this folder

   Further;

      .  Currently, this collection of scripts (toolkit) only
         supports;

         ..  GCP/GKE
         ..  This toolkit was written and tested on Ubuntu 18.
             You may find grievances when running on other
             platforms.
         ..  Version 0.5 of the KGIP helm charts.

      .  All files in this toolkit expect to run from the command
         line (from a Linux prompt) and via the 'root' users.


   Required Software
   ------------------------------------------------------

   The following software needs to be installed and in your PATH;

      .  helm
      .  docker          (currently used to manage Docker container images)
      .  gcloud
            google-cloud-sdk
            google-cloud-cli
      .  kubectl
      .  github cli

      .  jq
      .  curl
      .  envsubst        (common on Linux, usually an optional install on Mac)


   Required Permissions/Access
   ------------------------------------------------------

      .  You need a good amount of permissions inside a GCP project.
         Sorry; I was not able to test this.

         Start with,

            gcloud auth login
            gcloud projects list
            gcloud config list

         There are just some things you must be told. For example, 
  
            .  Which GCP project are you supposed to be using ?
            .  Which GCP geographies are you supposed to make things in ?

         And once you know your GCP project,

            gcloud config set project  {GCP_PROJECT_NAME}

      .  You need to be able to successfully run this command,

            gsutil ls gs://a62ce480-artifacts/versions

         We download Docker container images from the Url listed above.
         The above is a GCS storage bucket that is currently internal/
         private to Katana Graph.

      .  You need to be able to successfully run this command,

            gcloud container clusters list

         The above lists GKE clusters for a given GCP project. As stated
         above, you need a  {GCP_PROJECT_NAME}

      .  You need to be able to authenticate against GitHub.

            gh auth login
   
         Currently we download from a private Katana Graph GitHub
         repository.
         GitHub recently dis-allowed all password authentication.
         Thus, you need a GitHub token from the private Katana Graph
         GitHub repository. This is something you can get/create
         yourself.

         See,
            https://devops.pingidentity.com/how-to/privateRepos/
            https://github.com/settings/tokens

         You only need the token value. We've written the code-


   How to use the (defaults) file
   ------------------------------------------------------

      There is a file in this current working directory titled,

         20_Defaults.sh

      Written in Bash shell, you must set a number of environment
      variable values in this file.

      See the comments in file 20* for instructions towards setting
      these values.

      This should be the only file you ever need to edit in order
      to use this toolkit effectively.


   Operating the programs in this folder

   ------------------------------------------------------

      This toolkit contains the following files;


      **  Files in the 0* range are informational only-

      .  00 My Notes KG-K8s.txt
             #
          Contains random notes made when creating this toolkit.
          Also includes instructions for installing pre-requisite
          programs like; docker, helm, (other), atop Ubuntu 18.

      .  04_READ_ME.txt
            #
         Is this file you are reading.


      **  Files in the 2* range are for configuration-

      .  20_Defaults.sh
            #
         Was detailed above, and is documented internally.
         You will need to edit this file before using this toolkit
         effectively.

      .  23_GetCreds.sh
            and
         24_push.sh
            #
         Are files you may ignore.
         These two files together enable you to automate pushing
         changes made to programs inside your Jupyter NoteBook
         to a private GitHub repository.
            #
         But, supporting these files are out of scope as it relates
         to this toolkit.


      **  Files in the 3* range generally-

      .  Write, are destructive

      .  Create|Destroy the; K8s cluster, artifacts in the K8s cluster
         required by KGIP, other

         ..  30_DestroyK8sCluster.sh
                #
             Destroys the K8s cluster

         ..  31_CreateK8sCluster.sh
                #
             Creates the K8s cluster

         ..  32_DestroyKgAddOns.sh
                #
             Destroys specific artifacts either in GCP or GKE, that are required
             by the KGIP software.

         ..  33_CreateKgAddOns.sh
                #
             Creates specific artifacts either in GCP or GKE, that are required
             by the KGIP software.

         ..  36_ManageDockerImages.sh
                #
             In it's current form, we;

             ...  Download Docker images from a GCS storage bucket.
             ...  Use a local Docker repository to then push these
                  images into a repository accissble by our GKE
                  cluster.

          This program manages all of the process associated here.


      **  Files in the 4* range generally-

      .  Write, are destructive

      .  Manage items post the K8s cluster, meaning; the K8s cluster is
         done. All remaining work affects the contents of the K8s cluster
         or related.

         ..  40_StopK8sCluster.sh__
                and
             41_StartK8sCluster.sh__

             Do not work; are defective.
             Eventually, these should stop|start the K8s cluster without
             having to destroy|delete the K8s cluster.

         ..  44_GetKgHelmChart.sh
                #
             Character based menu driven, this program downloads, unzips,
             other, the KGIP helm charts that enable Kubernetes operations
             using helm, other.

         ..  45_PersonalizeB8.yaml
                #
             Effectively, automates editing of a YAML file that provides
             the final configuration choices for your KGIP cluster.


      **  Files in the 5* range generally-

      .  Write, are destructive

      .  50_DeleteKgCluster.sh
         and
         51_CreateKgCluster.sh
            #
         Delete|Create your KGIP cluster


      **  Files in the 6* range generally-

      .  Write, are destructive

      .  60_DeleteLocalDockerImages.sh
            and
         61_DeleteRemoteGkeDockerImages.sh
            #
         Using file 36* above, you are moving/copying Docker container images
         here and there.
         These two files allow you a character baed interface to see and then
         delete some of the large container files.


      **  Files in the 7*-8* range generally-

      .  Are read-only, non-destructive
      .  Generally,

         ..  Files 7*  relate to K8s
         ..  Files 8*  relate to KGIP

      .  70_GetK8sClusters.sh
      .  71_GetK8sNodes.sh
      .  72_GetK8sAllPods.sh
      .  73_GetK8sAllCrds.sh
      .  74_GetServiceAccounts.sh
      .  75_GetServices.yaml
      .  76_GetGkeVersions.sh
      .  78_ListHelmRepos.sh
      .  79_GetPvsPvcs.sh

      .  (the next file in this sequence/group, once created, will be named, 7A*, 7B*, .. )

      .  80_GetOnlyKgPodsWithLoop.sh
      .  81_GetLocalDockerImages.sh
      .  82_GetRemoteGkeDockerImages.sh
      .  83_GetKgNodesDetail.sh
      .  84_GetKgPodDfOutput.sh
      .  85_GetKgPodLogsWithTail.sh
      .  86_BashIntoKgPod.sh
      .  89_GetJupyterIpAddress.sh

      .  (the next file in this sequence/group, once created, will be named, 8A*, 8B*, .. )


      **  Files in the B*- and greater range generally-
 
      .  Are data files only (not programs)
      .  (n) Are folders

         ..  B1_KatanaHelmCharts
                #
             Contains the unzipped KGIP helm charts
             Programs above to change the contents of this folder per
             your direction.
 
         ..  C1_KatanaContainerImages
                #
             Contains Docker images, and can grow quite large.

         ..  TT_NotInUse_Experimental

      .  (n) Are files proper

         ..  B8_ValuesOverrideTemplate.yaml
                and
             BA_SimpleVersionOfB8_OneNodePool.yaml
                and
             BB_BetterVersionOfB8_MultipleNodePools.yaml
                #
             Are "values over rides YAML files".
             In effect, you edit B8* as you learn the KGIP YAMLs/helm-charts
             to further personalize your KGIP installation.
                #
             B8* is the file that matters.
             Files BA* and BB* are versions of file B8*.

         ..  BH_BancoFromHadi.yaml
                #
             Is/was the same function file, from Banco.
             Used as an example.






