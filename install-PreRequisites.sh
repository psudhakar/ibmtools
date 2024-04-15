#!/bin/bash
#This script installs the pre-req secrets, PVCs, Jaeger and Home page on Openshift

source icca.properties

function preReqICCACore() {
  #Create a namespace and image pull secret to pull the docker images from IBM ICR Registry
  echo -e "${YELLOW}*****Creating Pre-requisites required for installation of ICCA Core services*****"
  oc create namespace ${namespace} 2>&1 | grep -E --colour=always 'error'
  oc create secret docker-registry ibm-dip --docker-server=us.icr.io --docker-username=${ibmdip_dockerUsername} --docker-password=${ibmdip_dockerPassword} --docker-email=${dockerEmail} -n ${namespace} 2>&1 | grep -E --colour=always 'error'
  oc patch serviceaccount default -p '{"imagePullSecrets": [{"name": "ibm-dip"}]}' -n ${namespace} 2>&1 | grep -E --colour=always 'error'

  oc create secret docker-registry ibmicrio --docker-server=us.icr.io --docker-username=${ibmicrio_dockerUsername} --docker-password=${ibmicrio_dockerPassword} --docker-email=${dockerEmail} -n ${namespace} 2>&1 | grep -E --colour=always 'error'
  oc patch serviceaccount default -p '{"imagePullSecrets": [{"name": "ibmicrio"}]}' -n ${namespace} 2>&1 | grep -E --colour=always 'error'

  oc create secret docker-registry ibm-cr --docker-server=us.icr.io --docker-username=${ibmcr_dockerUsername} --docker-password=${ibmcr_dockerPassword} --docker-email=${dockerEmail} -n ${namespace} 2>&1 | grep -E --colour=always 'error'
  oc patch serviceaccount default -p '{"imagePullSecrets": [{"name": "ibm-cr"}]}' -n ${namespace} 2>&1 | grep -E --colour=always 'error'

  oc create secret generic ibm-login-config --namespace=${namespace} \
  --from-literal=SECURITY_CLIENT_ID=${securityClientID} \
  --from-literal=SECURITY_CLIENT_SECRET=${securityClientSecret} 2>&1 | grep -E --colour=always 'error'

  oc create secret generic ibm-login-config-mw --namespace=${namespace} \
  --from-literal=CLIENT_ID=${clientID} \
  --from-literal=CLIENT_SECRET=${clientSecret} 2>&1 | grep -E --colour=always 'error'

  oc adm policy add-scc-to-user anyuid -z igm4c-sa -n ${namespace}

}

#####Create PVC for ICCA services in ${namespace}#####
function preReqDIPDMB() {
    echo -e "${YELLOW}*****Creating Persistent Volume Claims for DIP DMB Services*****"
    echo -e "${YELLOW}*****Creating PVC for dip-ui-template-manager *****"

cat <<EOF >pvc-dip-ui-template-manager.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: dip-common-log-pvc
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

  oc apply -f pvc-dip-ui-template-manager.yaml

  oc create secret generic jenkins-credentials --namespace=${namespace} \
  --from-literal=jenkinsPassword=${dipTempMan-JenkinsPassword} \
  --from-literal=jenkinsPasswordKey=${dipTempMan-JekinsPasswordKey} \
  --from-literal=jenkinsUsername=${dipTempMan-JekninsUsername} \
  --from-literal=jenkinsUsernameKey=${dipTempMan-JenkinsUsernameKey} 2>&1 | grep -E --colour=always 'error'

  oc create secret generic dip-ui-template-manager-config --namespace=${namespace} \
  --from-literal=mongoURI=${dip-mongoURI} 2>&1 | grep -E --colour=always 'error'

echo -e "${YELLOW}*****Creating PVC for Rest Container*****"
cat <<EOF >pvc-rest-container.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: dmb-generated-code
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

     oc apply -f pvc-rest-container.yaml
}

function preReqDIPDSB() {

    echo -e "${YELLOW}*****Creating Persistent Volume Claims for DIP DSB Services*****"

    echo -e "${YELLOW}******Creating Service Account igm4c-sa*****"
    oc create sa igm4c-sa 2>&1 | grep -E --colour=always 'error'
    oc adm policy add-scc-to-user anyuid -z igm4c-sa -n ${namespace}

    echo -e "${YELLOW}*****Creating PVC for Event Container*****"

cat <<EOF >pvc-event-container.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: dsb-generated-code
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

     oc apply -f pvc-event-container.yaml 2>&1 | grep -E --colour=always 'unchanged'

cat <<EOF >pvc-event-container-log.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: dsb-logs
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

     oc apply -f pvc-event-container-log.yaml 2>&1 | grep -E --colour=always 'unchanged'
}

function preReqCMA() {

    echo -e "${YELLOW}*****Creating Persistent Volume Claims for CMA Services*****"
    echo -e "${YELLOW}*****Creating PVC which is shared by cma-bff, microservice evaluator and microservice recommender*****"

cat <<EOF >pvc-cma-bff.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: cma-bff-pvc
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

    oc apply -f pvc-cma-bff.yaml 2>&1 | grep -E --colour=always 'unchanged'

    echo -e "${YELLOW}*****Creating PVC which is shared by evaluator*****"

cat <<EOF >cma-bff-ms-recommender-ms-evaluator.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: cma-bff-ms-recommender-ms-evaluator
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

  oc apply -f cma-bff-ms-recommender-ms-evaluator.yaml 2>&1 | grep -E --colour=always 'unchanged'
}

function preReqCTI() {

    echo -e "${YELLOW}*****Creating Persistent Volume Claims for CTI Services*****"
    echo -e "${YELLOW}*****Creating PVC which is shared by analytics*****"

cat <<EOF >pvc-analytics.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: dip-common-log-pvc-2
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

    oc apply -f pvc-analytics.yaml 2>&1 | grep -E --colour=always 'unchanged'

    echo -e "${YELLOW}*****Creating PVC which is shared by ingestion*****"

cat <<EOF >pvc-ingestion.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: ingestion-pvc
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

    oc apply -f pvc-ingestion.yaml 2>&1 | grep -E --colour=always 'unchanged'

}

function preReqMAM() {

    echo -e "${YELLOW}*****Creating Persistent Volume Claims for MAM Services*****"

    echo -e "${YELLOW}******Creating Service Account igm4c-sa*****"
    oc create sa igm4c-sa 2>&1 | grep -E --colour=always 'error'

    echo -e "${YELLOW}*****Creating PVC which is shared by MAM-CA and Mainframe-Mod*****"

cat <<EOF >pvc-mainframe-mod.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mainframe-mod-pvc
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 20Gi
  storageClassName: ${storageClass}
  volumeMode: Filesystem
EOF

    oc apply -f pvc-mainframe-mod.yaml 2>&1 | grep -E --colour=always 'unchanged'

cat <<EOF >pvc-influxdb.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: influxdb-data-influxdb-0
  namespace: ${namespace}
  labels:
    app: abc
    app.kubernetes.io/managed-by: Helm
  annotations:
    meta.helm.sh/release-name: rbac
    meta.helm.sh/release-namespace: ${namespace}
spec:
accessModes:
  - ReadWriteMany
resources:
  requests:
    storage: 20Gi
storageClassName: ${storageClass}
volumeMode: Filesystem
EOF

  oc apply -f pvc-influxdb.yaml 2>&1 | grep -E --colour=always 'unchanged'

  oc create secret generic influxdb-connection-secret --namespace=${namespace} \
  --from-literal=MAM_INFLUXDB_AUTHENTICATION=${MAM_INFLUXDB_AUTHENTICATION} \
  --from-literal=MAM_INFLUXDB_BUCKET=${MAM_INFLUXDB_BUCKET} \
  --from-literal=MAM_INFLUXDB_DATABASE=${MAM_INFLUXDB_DATABASE} \
  --from-literal=MAM_INFLUXDB_HOST=${MAM_INFLUXDB_HOST} \
  --from-literal=MAM_INFLUXDB_HOSTNAME=${MAM_INFLUXDB_HOSTNAME} \
  --from-literal=MAM_INFLUXDB_ORG=${MAM_INFLUXDB_ORG} \
  --from-literal=MAM_INFLUXDB_PASSWORD=${MAM_INFLUXDB_PASSWORD} \
  --from-literal=MAM_INFLUXDB_PORT=${MAM_INFLUXDB_PORT} \
  --from-literal=MAM_INFLUXDB_TOKEN=${MAM_INFLUXDB_TOKEN} \
  --from-literal=MAM_INFLUXDB_USERNAME=${MAM_INFLUXDB_USERNAME} \
  --from-literal=MAM_INFLUXDB_VERSION=${MAM_INFLUXDB_VERSION} 2>&1 | grep -E --colour=always 'error'

  oc create secret generic influxdb-secret --namespace=${namespace} \
  --from-literal=BUCKET_NAME=${BUCKET_NAME} \
  --from-literal=MAM_INFLUXDB_PASSWORD=${MAM_INFLUXDB_PASSWORD} \
  --from-literal=MAM_INFLUXDB_USERNAME=${MAM_INFLUXDB_USERNAME} \
  --from-literal=ORGANIZATION_NAME=${ORGANIZATION_NAME} \
  --from-literal=TOKEN=${TOKEN} 2>&1 | grep -E --colour=always 'error'


}
