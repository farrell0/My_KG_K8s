#!/bin/bash


#  GCP machines types,
#     https://cloud.google.com/compute/docs/general-purpose-machines#e2_machine_types
#     https://cloud.google.com/compute/docs/regions-zones#available

#  GCP zones,
#     gcloud compute zones list


#  Currently our doc requests K8s version:   v1.22.15
#  See,
#     https://docs.k9h.dev/latest/docs/install-k8s/prerequisites.html
#
#  See file 20* for getting and setting GKE version.
#


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "Step 1 of 2: Calling 'gcloud' to create K8s cluster ..."
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo "       (This command takes 4+ minutes to complete.)"
echo ""
sleep 10


#  Generated via the GKE UI and our doc,
#
gcloud beta container --project "${GCP_PROJECT_NAME}"                                    \
   clusters create "${GKE_CLUSTER_NAME}"                                                 \
   --zone "${GCP_REGION}"                                                                \
   --node-locations "${GCP_ZONE}"                                                        \
   --cluster-version "${MY_GKE_CLUSTER_VERSION}"                                         \
                                                                                         \
   --network "projects/${GCP_PROJECT_NAME}/global/networks/default"                      \
   --subnetwork "projects/${GCP_PROJECT_NAME}/regions/${GCP_REGION}/subnetworks/default" \
   --workload-pool "${GCP_PROJECT_NAME}.svc.id.goog"                                     \
                                                                                         \
   --image-type "COS_CONTAINERD"                                                         \
   --machine-type "${KATANA_CONTROL_VM_TYPE}"                                            \
   --disk-type "pd-standard"                                                             \
   --disk-size "1000"                                                                    \
   --num-nodes ${MY_KATANA_CONTROL_VM_TYPE_COUNT}                                        \
                                                                                         \
   --max-pods-per-node "110"                                                             \
   --no-enable-basic-auth                                                                \
   --addons HorizontalPodAutoscaling,HttpLoadBalancing,GcePersistentDiskCsiDriver        \
   --release-channel "None"                                                              \
   --enable-ip-alias                                                                     \
   --metadata disable-legacy-endpoints=true                                              \
   --default-max-pods-per-node "110"                                                     \
   --no-enable-master-authorized-networks                                                \
   --no-enable-intra-node-visibility                                                     \
   --no-enable-autoupgrade                                                               \
   --no-enable-autorepair                                                                \
   --max-surge-upgrade 1                                                                 \
   --max-unavailable-upgrade 0                                                           \
   --logging=SYSTEM,WORKLOAD                                                             \
   --monitoring=SYSTEM                                                                   \
                                                                                         \
   --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \

echo ""
echo "Step 2 of 2: Calling 'gcloud' to add a second node pool .."
echo ""


gcloud beta container --project "${GCP_PROJECT_NAME}"                                    \
   node-pools create "worker-pool"                                                       \
   --cluster "${GKE_CLUSTER_NAME}"                                                       \
   --zone "${GCP_REGION}"                                                                \
   --node-locations "${GCP_ZONE}"                                                        \
                                                                                         \
   --image-type "COS_CONTAINERD"                                                         \
   --machine-type "${KATANA_WORKER_VM_TYPE}"                                             \
   --disk-type "pd-standard"                                                             \
   --disk-size "1000"                                                                    \
   --num-nodes ${MY_KATANA_WORKER_VM_TYPE_COUNT}                                         \
                                                                                         \
   --metadata disable-legacy-endpoints=true                                              \
   --no-enable-autoupgrade                                                               \
   --no-enable-autorepair                                                                \
   --max-surge-upgrade 1                                                                 \
   --max-unavailable-upgrade 0                                                           \
   --max-pods-per-node "110"                                                             \
                                                                                         \
   --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" 


##############################################################


echo ""
echo ""
echo "Next steps:"
echo ""
echo "   .  Run file 33* to create specific Katana Graph required"
echo "      resources inside this K8s cluster."

echo ""
echo ""






