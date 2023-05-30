#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "(Many steps): Creating given Katana Graph required objects"
echo "inside Kubernetes .."
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
sleep 10


echo ""
echo "Step 1: Fetching GCP credentials .."
gcloud container clusters get-credentials ${GKE_CLUSTER_NAME} --project ${GCP_PROJECT_NAME} --zone ${GCP_REGION}       #  Asks for ZONE, seems to want REGION
echo ""


echo ""
echo "Step 2: Create namespace .."
kubectl create namespace ${MY_NAMESPACE}
echo ""


#  You can default all kubectl commands to a given name space using the below.
#  We prefer to not do that-
#
#  kubectl config set-context --current --namespace=${MY_NAMESPACE}


echo ""
echo "Step 3: Installing MPI Operator(CRD) .."
kubectl apply -k "github.com/kubeflow/training-operator/manifests/overlays/standalone?ref=v1.5.0"
echo ""


echo ""
echo "Step 4: Installing Dask Operator(CRD) .."
helm install --repo https://helm.dask.org --create-namespace -n dask-operator --generate-name dask-kubernetes-operator
echo ""


##############################################################
##############################################################


#  As a general topic; GCP workload identity, see,
#     https://medium.com/@mohanpedala/enable-workload-identity-on-gke-cluster-9ff139baa2ea

#  For testing; removing a GS bucket 
#     gsutil -m rm -r gs://${MY_BUCKET}

echo ""
echo "Step 5: Creating mandatory GCP/GS bucket, and Kubernetes Service Account to manage same .."
   #
gcloud storage buckets create ${GCS_BUCKET} --project=${GCP_PROJECT_NAME} --default-storage-class=NEARLINE --location=${GCP_REGION}      #  --uniform-bucket-level-access
echo ""

   ###

kubectl create serviceaccount ${KATANA_SERVICE_ACCOUNT_NAME} --namespace ${MY_NAMESPACE}

gcloud iam service-accounts add-iam-policy-binding ${GCP_SERVICE_ACCOUNT}                                     \
   --role roles/iam.workloadIdentityUser                                                                      \
   --member "serviceAccount:${GCP_PROJECT_NAME}.svc.id.goog[${MY_NAMESPACE}/${KATANA_SERVICE_ACCOUNT_NAME}]"   \
   --project ${GCP_PROJECT_NAME}

kubectl annotate serviceaccount ${KATANA_SERVICE_ACCOUNT_NAME}                                                \
   --namespace ${MY_NAMESPACE} iam.gke.io/gcp-service-account=${GCP_SERVICE_ACCOUNT}

echo ""


##############################################################


echo ""
echo "Step 6: Enable our KGIP servcie account access to a centralized"
echo "GCS storage bucket with common datasets .."
   #



echo ""
echo ""
echo ""
echo ""





##############################################################


#  Enable the GCP/GKE container repository.
#  
#  This comes from this page in our doc,
#     https://docs.k9h.dev/latest/docs/install-k8s/install-kg.html
#
#  See also this doc,
#     https://cloud.google.com/container-registry/docs/enable-service#gcloud
#  
echo ""
echo "Step 7: Enabling GKE container repository .."
gcloud services enable containerregistry.googleapis.com


##############################################################


echo ""
echo ""
echo "Next steps:"
echo ""
echo "   You have the K8s cluster with all Katana Graph required"
echo "   entities present. (Storage buckets, service accounts, etc.)"
echo ""
echo "   .  Run file 36* to manage the Docker container images needed"
echo "      for the various Katana Graph Intelligence Platform pods."
echo ""
echo "   .  Run file 45* to 'personalize' you YAML file relative to"
echo "      the KGIP cluster proper."
echo ""
echo "   .  Run file 51* to actually provision the KGIP cluster."

echo ""
echo ""




