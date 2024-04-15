#!/bin/bash
#This script adds the Helm repository and installs the Helm Charts of the ICCA services

source icca.properties
source install-ReverseProxy.sh

function addHelmRepo() {

    echo -e "${YELLOW}*****Adding the Helm Charts repository*****"
    local chartmuseumrepo="$1"
    local chartmuseumrepopath="$2"

    helm repo add ${chartmuseumrepo} cm://chartmuseum-tools.fp-factory1-1606237964144-f72ef11f3ab089a8c677044eb28292cd-0000.sjc03.containers.appdomain.cloud/${chartmuseumrepopath}
    retVal=$?
    if [ $retVal -eq 0 ]; then
        echo -e "${GREEN}success: Added helm chart repository chartmuseum"
    else
        echo -e "${RED}error: Failed to add Helm Charts repository. Return Code: ${retVal}"
        exit 1
    fi

    helm repo update ${chartmuseumrepo}
    retVal=$?
    if [ $retVal -eq 0 ]; then
        echo -e "${GREEN}success: Updated chat repository chartmuseum"
    else
        echo -e "${RED}error: Failed to update Helm Charts repository. Return Code: ${retVal}"
        exit 1
    fi
}

function ICCACore() {

     export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_ICCA_Core}"
     addHelmRepo "ICCA-Core" "ICCA/ICCA-Core"

     echo -e "${YELLOW}*****Installing Helm Charts of ICCA Core Services of version: $version*****"

     echo -e "${YELLOW}*****Installing Helm Chart of ICCA-Integrated-UI*****"
     helm install icca ICCA-Core/integrated-ui  --namespace ${namespace}  --version $version
     retVal=$?
     if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "icca-integrated-ui" has been installed!"
     else
         echo -e "${RED}error: Failed to install ICCA-Integrated-UI Helm Chart. Return Code: ${retVal}"
         exit 1
     fi


     echo -e "${YELLOW}*****Installing Helm Chart of ICCA-Middleware*****"
     helm install icca-mw ICCA-Core/middleware  --namespace ${namespace} --version ${version}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "icca-mw-middleware" has been installed!"
     else
         echo -e "${RED}error: Failed to install ICCA-Middleware Helm Chart. Return Code: ${retVal}"
         exit 1
     fi



     echo -e "${YELLOW}*****Installing Helm Chart of RBAC*****"
     helm install --set persistentVolume.storageClassName="${storageClass}"  rbac ICCA-Core/rbac  --namespace ${namespace}  --version $version
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "rbac" has been installed!"
     else
          echo -e "${RED}error: Failed to install RBAC Helm Chart. Return Code: ${retVal}"
          exit 1
     fi


}

function dipCodeTransporter() {

     export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_CT}"
     addHelmRepo "ICCA-Code-Transporter" "ICCA/CodeTransporter"
     echo -e "${YELLOW}*****Installing Helm Charts of Accelerator Services-DIP of version: $version*****"
     echo -e "${YELLOW}*****Installing Helm Chart of DIP Code Transporter UI*****"
     helm install dip-code-transporter-ui ICCA-Code-Transporter/dip-code-transporter-ui  --namespace ${namespace} --version ${version}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-code-transporter-ui" has been installed!"
     else
          echo -e "${RED}error: Failed to install DIP Code Transporter UI Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****Installing Helm Chart of DIP Code Transporter Backend*****"
     helm install dip-code-transporter ICCA-Code-Transporter/dip-code-transporter  --namespace ${namespace} --version ${version}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-code-transporter" has been installed!${NOCOLOUR}"
     else
          echo -e "${RED}error: Failed to install DIP Code Transporter Backend Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

}

function dipDMB() {

     export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_DMB}"
     addHelmRepo "ICCA-DMB" "ICCA/DMB"
     echo -e "${YELLOW}*****Installing Helm Charts of Accelerator Services-DIP of version: $version*****"
     echo -e "${YELLOW}*****Installing Helm Chart of Templatized DMB*****"
     helm install dip-templatize-dmb-ui ICCA-DMB/dip-templatize-dmb-ui  --namespace ${namespace} --version ${version}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-templatize-dmb-ui" has been installed!"
     else
          echo -e "${RED}error: Failed to install Templatized DMB Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****Installing Helm Chart of DMB Template Manager UI*****"
     helm install dip-ui-template-manager ICCA-DMB/dip-ui-template-manager  --namespace ${namespace} --version ${version}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-ui-template-manager" has been installed!"
     else
          echo -e "${RED}error: Failed to install DMB Template Manager UI Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****Installing Helm Chart of Rest Container*****"
     helm install dip-rest-container ICCA-DMB/dip-rest-container  --namespace ${namespace} --version ${version}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-rest-container" has been installed!"
     else
          echo -e "${RED}error: Failed to install Rest Container Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

}

function dipDSB() {

     export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_DSB}"
     addHelmRepo "ICCA-DSB" "ICCA/DSB"
     echo -e "${YELLOW}*****Installing Helm Charts of Accelerator Services-DIP of version: $version*****"
     echo -e "${YELLOW}*****Installing Helm Chart of DSB-UI*****"
     helm install dip-dsb-ui ICCA-DSB/dip-dsb-ui  --namespace ${namespace} --version ${version}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-dsb-ui" has been installed!"
     else
          echo -e "${RED}error: Failed to install DSB-UI Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****Installing Helm Chart of Event Container*****"
     helm install dip-event-container ICCA-DSB/event-container  --namespace ${namespace} --version ${version}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-event-container" has been installed!"
     else
          echo -e "${RED}error: Failed to install Event Container Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

    echo -e "${YELLOW}*****Installing Helm Chart of Oneclick*****"
    helm install dip-oneclick ICCA-DSB/dip-oneclick  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "dip-oneclick" has been installed!"
    else
         echo -e "${RED}error: Failed to install Oneclick Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

}

function CMA() {

    export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_CMA}"
    addHelmRepo "ICCA-CMA" "ICCA/CMA"
    echo -e "${YELLOW}*****Installing Helm Charts of Accelerator Services-CMA of version: $version*****"

    echo -e "${YELLOW}*****Installing Helm Chart of CMA-BFF*****"
    helm install cma-bff ICCA-CMA/cma-bff  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "cma-bff" has been installed!"
    else
         echo -e "${RED}error: Failed to install CMA-BFF Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of Microservice-Evaluator*****"
    helm install microservices-evaluator ICCA-CMA/microservices-evaluator  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "microservices-evaluator" has been installed!"
    else
         echo -e "${RED}error: Failed to install Microservice-Evaluator Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of Microservice-Recommender*****"
    helm install microservice-recommender ICCA-CMA/microservice-recommender  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "microservice-recommender" has been installed!"
    else
         echo -e "${RED}error: Failed to install Microservice-Recommender Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of GM4C-MFE-CMA*****"
    helm install gm4c-mfe-app-cma ICCA-CMA/gm4c-mfe-app-cma  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "gm4c-mfe-app-cma" has been installed!"
    else
         echo -e "${RED}error: Failed to install CMA Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    if oc get statefulsets neo4j -n ${namespace} &>/dev/null; then
       echo "NEO4J is installed in project/namespace ${namespace}."
    else
       export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_ICCA_Core}"
       addHelmRepo "ICCA-Core" "ICCA/ICCA-Core"
       echo -e "${YELLOW}*****Installing Helm Chart of NEO4J*****"
            helm install --set persistentVolume.storageClassName="${storageClass}" neo4j ICCA-Core/neo4j  --namespace ${namespace} --version ${version}
            retVal=$?
            if [ $retVal -eq 0 ]; then
                 echo -e "${GREEN}success: Release "neo4j" has been installed!${NOCOLOUR}"
            else
                 echo -e "${RED}error: Failed to install NEO4J Helm Chart. Return Code: ${retVal}"
                 exit 1
            fi
    fi

}

function CTI() {

    export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_CTI}"
    addHelmRepo "ICCA-CTI" "ICCA/CTI"
    echo -e "${YELLOW}*****Installing Helm Charts of Accelerator Services-CTI of version: $version*****"

    echo -e "${YELLOW}*****Installing Helm Chart of Analytics*****"
    helm install analytics ICCA-CTI/analytics  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "analytics" has been installed!"
    else
         echo -e "${RED}error: Failed to install Analytics Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of Ingestion*****"
    helm install ingestion ICCA-CTI/ingestion  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "ingestion" has been installed!"
    else
         echo -e "${RED}error: Failed to install Ingestion Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of GM4C-MFE-CTI*****"
    helm install gm4c-mfe-app-cti ICCA-CTI/gm4c-mfe-app-cti  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "gm4c-mfe-app-cti" has been installed!"
    else
         echo -e "${RED}error: Failed to install GM4C-MFE-CTI Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    if oc get statefulsets neo4j -n ${namespace} &>/dev/null; then
           echo "NEO4J is installed in project/namespace ${namespace}."
    else
       export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_ICCA_Core}"
       addHelmRepo "ICCA-Core" "ICCA/ICCA-Core"
       echo -e "${YELLOW}*****Installing Helm Chart of NEO4J*****"
            helm install --set persistentVolume.storageClassName="${storageClass}" neo4j ICCA-Core/neo4j  --namespace ${namespace} --version ${version}
            retVal=$?
            if [ $retVal -eq 0 ]; then
                 echo -e "${GREEN}success: Release "neo4j" has been installed!${NOCOLOUR}"
            else
                 echo -e "${RED}error: Failed to install NEO4J Helm Chart. Return Code: ${retVal}"
                 exit 1
            fi
    fi

}

function MAM() {

    export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_MAM}"
    addHelmRepo "ICCA-MAM" "ICCA/MAM"
    echo -e "${YELLOW}*****Installing Helm Charts of Accelerator Services-MAM of version: $version*****"

    echo -e "${YELLOW}*****Installing Helm Chart of InfluxDB*****"
    helm install influxdb ICCA-MAM/influxdb  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "influxdb" has been installed!"
    else
        echo -e "${RED}error: Failed to install InfluxDB Helm Chart. Return Code: ${retVal}"
        exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of Data Services*****"
    helm install data-services ICCA-MAM/data-services  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "data-services" has been installed!"
    else
         echo -e "${RED}error: Failed to install Data Services Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of Mainframe-Mod*****"
    helm install mainframe-mod ICCA-MAM/mainframe-mod  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "mainframe-mod" has been installed!"
    else
         echo -e "${RED}error: Failed to install Mainframe-Mod Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of MAM-CA*****"
    helm install mam-ca ICCA-MAM/mam-ca  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "mam-ca" has been installed!"
    else
         echo -e "${RED}error: Failed to install MAM-CA Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of MAM-OPSKPIS*****"
    helm install mam-opskpis ICCA-MAM/mam-opskpis  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "mam-opskpis" has been installed!"
    else
         echo -e "${RED}error: Failed to install MAM-OPSKPIS Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****Installing Helm Chart of GM4C-MFE-MAM*****"
    helm install gm4c-mfe-app-mam ICCA-MAM/gm4c-mfe-app-mam  --namespace ${namespace} --version ${version}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "gm4c-mfe-app-mam" has been installed!${NOCOLOUR}"
    else
         echo -e "${RED}error: Failed to install GM4C-MFE-MAM Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    if oc get statefulsets neo4j -n ${namespace} &>/dev/null; then
               echo "NEO4J is installed in project/namespace ${namespace}."
    else
       export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_ICCA_Core}"
       addHelmRepo "ICCA-Core" "ICCA/ICCA-Core"
       echo -e "${YELLOW}*****Installing Helm Chart of NEO4J*****"
            helm install --set persistentVolume.storageClassName="${storageClass}" neo4j ICCA-Core/neo4j  --namespace ${namespace} --version ${version}
            retVal=$?
            if [ $retVal -eq 0 ]; then
                 echo -e "${GREEN}success: Release "neo4j" has been installed!${NOCOLOUR}"
            else
                 echo -e "${RED}error: Failed to install NEO4J Helm Chart. Return Code: ${retVal}"
                 exit 1
            fi
    fi
}

function reverseProxy() {

    export HELM_REPO_ACCESS_TOKEN="${helmMuseumToken_ICCA_Core}"
    addHelmRepo "ICCA-Core" "ICCA/ICCA-Core"
    echo -e "${YELLOW}*****Installing Helm Chart of ICCA Reverse Proxy*****"
    helm upgrade --install icca-reverse-proxy ICCA-Core/icca-reverse-proxy  --namespace ${namespace} --values values/iccaCore/values-ICCA-reverse-proxy.yaml --version $version
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "icca-reverse-proxy" has been installed!${NOCOLOUR}"
    else
         echo -e "${RED}error: Failed to install ICCA Reverse Proxy Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

}
