#!/bin/bash


. "./20_Defaults.sh"


##############################################################


echo ""
echo ""
echo "(Many steps): Calling given GCP utilities to delete Katana"
echo "Graph required resources associated with the K8s cluster."
echo ""
echo "This will delete [ EVERYTHING ] that was inside a given"
echo "Katana Graph Intelligence Platform (cluster)."
echo ""
echo ""
echo "**  You have 10 seconds to cancel before proceeding."
echo ""
echo ""
sleep 10


#  These CRDs come with our base K8s
#
#     backendconfigs.cloud.google.com                  2023-02-21T16:12:48Z
#     capacityrequests.internal.autoscaling.gke.io     2023-02-21T16:12:30Z
#     frontendconfigs.networking.gke.io                2023-02-21T16:12:48Z
#     managedcertificates.networking.gke.io            2023-02-21T16:12:48Z
#     serviceattachments.networking.gke.io             2023-02-21T16:12:49Z
#     servicenetworkendpointgroups.networking.gke.io   2023-02-21T16:12:48Z
#     updateinfos.nodemanagement.gke.io                2023-02-21T16:13:01Z
#     volumesnapshotclasses.snapshot.storage.k8s.io    2023-02-21T16:13:00Z
#     volumesnapshotcontents.snapshot.storage.k8s.io   2023-02-21T16:13:00Z
#     volumesnapshots.snapshot.storage.k8s.io          2023-02-21T16:13:00Z


#  MPI makes these in file 33*
#
#     namespace/kubeflow created
#     customresourcedefinition.apiextensions.k8s.io/mpijobs.kubeflow.org created
#     customresourcedefinition.apiextensions.k8s.io/mxjobs.kubeflow.org created
#     customresourcedefinition.apiextensions.k8s.io/pytorchjobs.kubeflow.org created
#     customresourcedefinition.apiextensions.k8s.io/tfjobs.kubeflow.org created
#     customresourcedefinition.apiextensions.k8s.io/xgboostjobs.kubeflow.org created
#     serviceaccount/training-operator created
#     clusterrole.rbac.authorization.k8s.io/training-operator created
#     clusterrolebinding.rbac.authorization.k8s.io/training-operator created
#     service/training-operator created
#     deployment.apps/training-operator created
#
#  Undo the above
#
echo ""
echo "Step 1: Delete MPI related artifacts .."
   #
kubectl delete -k "github.com/kubeflow/training-operator/manifests/overlays/standalone?ref=v1.5.0"
echo ""


#  Our Dask install makes these in file 33*
#
#     NAME: dask-kubernetes-operator-1676996703
#     LAST DEPLOYED: Tue Feb 21 08:25:08 2023
#     NAMESPACE: dask-operator
#     STATUS: deployed
#     REVISION: 1
#     TEST SUITE: None
#     NOTES:
#     Operator has been installed successfully.
#
#     daskautoscalers.kubernetes.dask.org              2023-02-21T16:25:04Z
#     daskclusters.kubernetes.dask.org                 2023-02-21T16:25:04Z
#     daskjobs.kubernetes.dask.org                     2023-02-21T16:25:05Z
#     daskworkergroups.kubernetes.dask.org  
#
#  Undo the above
#
echo ""
echo "Step 2: Delete Dask related artifacts .."
   #
kubectl delete crd daskautoscalers.kubernetes.dask.org
kubectl delete crd daskclusters.kubernetes.dask.org
kubectl delete crd daskjobs.kubernetes.dask.org
kubectl delete crd daskworkergroups.kubernetes.dask.org  
   #
kubectl delete namespace dask-operator
echo ""


#  To see all roles in a project,
#     gcloud projects get-iam-policy ${GCP_PROJECT_NAME} --flatten="bindings[].members" --format='table(bindings.role)' 
#
#  To see all roles for a given user,
#     gcloud projects get-iam-policy ${GCP_PROJECT_NAME} --flatten="bindings[].members" --format='table(bindings.role)' \
#        --filter="bindings.members:${KATANA_SERVICE_ACCOUNT_NAME}@${GCP_PROJECT_NAME}.iam.gserviceaccount.com"
#
#  Or, at the K8s level,
#     kubectl get rolebindings,clusterrolebindings --all-namespaces -o wide
#
#  No filters,
#     gcloud projects get-iam-policy ${GCP_PROJECT_NAME}


echo ""
echo "Step 3: Delete GCP/GKE service account .."
#
#     **  I might have a bug here; I get a permissions error, but it might be my syntax
#
#  gcloud -q iam service-accounts delete ${KATANA_SERVICE_ACCOUNT_NAME}@${GCP_PROJECT_NAME}.iam.gserviceaccount.com
echo ""


#  For testing, to list buckets 
#     gcloud storage ls

echo ""
echo "Step 4: Delete GS storage bucket .."
   #
gsutil -m rm -r ${GCS_BUCKET}


echo ""
echo "Step 5: Delete K8s namespace .."
   #
kubectl delete namespace ${MY_NAMESPACE}
echo ""


echo ""
echo "Step 6: Delete Helm repository references .."
   #
helm repo remove bitnami
helm repo remove hashicorp
helm repo remove jupyterhub
helm repo update
echo ""


#  Was experimenting with adding a static external IP
#
#  Did not complete that.
#
#  echo ""
#  echo "Step 7: Delete objects for external GCP IP address .."
#     #
#  gcloud -q compute addresses delete  ${GKE_CLUSTER_NAME}-ip  --region ${GCP_REGION}
#  echo ""


echo ""
echo ""






