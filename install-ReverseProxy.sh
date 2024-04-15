#!/bin/bash
#This script adds the Helm repo and installs the Helm Charts of the ICCA reverse proxy

source icca.properties

function ICCACoreServices() {

     echo "${YELLOW}*****The below services will be set in reverse proxy*****"

     echo "${YELLOW}*****The below domain name will be set in reverse proxy*****"
     sed -i -e "s|<domainName>|${domainName}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

     echo "${YELLOW}*****The below integratedUIService service will be set in reverse proxy*****"
     integratedUIService="$(oc get svc icca-integrated-ui -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
     echo "integratedUI Service- $integratedUIService"
     sed -i -e "s|<integratedUIService>|${integratedUIService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

     echo "${YELLOW}*****The below middlewareService service will be set in reverse proxy*****"
     middlewareService="$(oc get svc icca-mw-middleware -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
     echo "Middleware Service- $middlewareService"
     sed -i -e "s|<middlewareService>|${middlewareService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml
}

function dipCodeTransporterServices() {

     echo "${YELLOW}*****The below Code Transporter UI service will be set in reverse proxy*****"
     codetransporterUIService="$(oc get svc dip-code-transporter-ui -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
     echo "Code Transporter UI Service- $codetransporterUIService"
     sed -i -e "s|<codetransporterUIService>|${codetransporterUIService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

     echo "${YELLOW}*****The below Code Transporter Backend service will be set in reverse proxy*****"
     codetransporterBackendService="$(oc get svc dip-code-transporter -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
     echo "Code Transporter Backend Service- $codetransporterBackendService"
     sed -i -e "s|<codetransporterBackendService>|${codetransporterBackendService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml
}

function dipDMBServices() {

    echo "${YELLOW}*****The below DMB UI service will be set in reverse proxy*****"
    dmbUIService="$(oc get svc dip-templatize-dmb-ui -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
    echo "DMB UI Service- $dmbUIService"
    sed -i -e "s|<dmbUIService>|${dmbUIService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

    echo "${YELLOW}*****The below DMB Backend service will be set in reverse proxy*****"
    dmbBackendService="$(oc get svc dip-ui-template-manager -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
    echo "DMB Backend Service- $dmbBackendService"
    sed -i -e "s|<dmbBackendService>|${dmbBackendService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

    echo "${YELLOW}*****The below Rest Container service will be set in reverse proxy*****"
    restContainerService="$(oc get svc dip-rest-container -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
    echo "Rest Container Service- $restContainerService"
    sed -i -e "s|<restContainerService>|${restContainerService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

}

function dipDSBServices() {

  echo "${YELLOW}*****The below DSB UI Service service will be set in reverse proxy*****"
  dsbUIService="$(oc get svc dip-dsb-ui -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
  echo "DSB UI Service- $dsbUIService"
  sed -i -e "s|<dsbUIService>|${dsbUIService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

  echo "${YELLOW}*****The below DSB Backend Service service will be set in reverse proxy*****"
  dsbBackendService="$(oc get svc dip-oneclick -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
  echo "DSB Backend Service- $dsbBackendService"
  sed -i -e "s|<dsbBackendService>|${dsbBackendService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

  echo "${YELLOW}*****The below Event Container Service service will be set in reverse proxy*****"
  eventContainerService="$(oc get svc dip-event-container -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
  echo "DSB Backend Service- $eventContainerService"
  sed -i -e "s|<eventContainerService>|${eventContainerService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

}

function cmaServices() {

    echo "${YELLOW}*****The below CMA Service service will be set in reverse proxy*****"
    cmaService="$(oc get svc gm4c-mfe-app-cma -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
    echo "CMA Service- $cmaService"
    sed -i -e "s|<cmaService>|${cmaService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

}

function ctiServices() {

    echo "${YELLOW}*****The below CTI Service service will be set in reverse proxy*****"
    ctiService="$(oc get svc gm4c-mfe-app-cti -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
    echo "CTI Service- $ctiService"
    sed -i -e "s|<ctiService>|${ctiService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

}

function mamServices() {

    echo "${YELLOW}*****The below MAM Service service will be set in reverse proxy*****"
    mamService="$(oc get svc gm4c-mfe-app-mam -n ${namespace} -o=jsonpath='http://{.metadata.name}.{.metadata.namespace}.svc.cluster.local:{.spec.ports..port}')"/
    echo "MAM Service- $mamService"
    sed -i -e "s|<mamService>|${mamService}|g" values/iccaCore/values-ICCA-reverse-proxy.yaml

}