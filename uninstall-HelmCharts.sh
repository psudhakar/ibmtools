#!/bin/bash
#This script uninstalls the Helm Charts of the ICCA services

function uninstallICCACore() {

     echo -e "${YELLOW}*****uninstalling Helm Charts of ICCA Services of version: $version*****"

     echo -e "${YELLOW}*****uninstalling Helm Chart of ICCA-Integrated-UI*****"
     helm uninstall icca --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "icca-integrated-ui" has been uninstalled!"
     else
          echo -e "${RED}error: Failed to uninstall ICCA-Integrated-UI Helm Chart. Return Code: ${retVal}"
          exit 1
     fi



     echo -e "${YELLOW}*****uninstalling Helm Chart of ICCA-Middleware*****"
     helm uninstall icca-mw --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "icca-mw-middleware" has been uninstalled!"
     else
         echo -e "${RED}error: Failed to uninstall ICCA-Middleware Helm Chart. Return Code: ${retVal}"
         exit 1
     fi

     echo -e "${YELLOW}*****uninstalling Helm Chart of RBAC*****"
     helm uninstall rbac --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "rbac" has been uninstalled!"
     else
          echo -e "${RED}error: Failed to uninstall RBAC Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****uninstalling PVC of RBAC*****"
     oc delete pvc rbac-pvc -n ${namespace}

     echo -e "${YELLOW}*****uninstalling Helm Chart of Reverse-Proxy*****"
     helm uninstall icca-reverse-proxy --namespace ${namespace}
      retVal=$?
      if [ $retVal -eq 0 ]; then
           echo -e "${GREEN}success: Release "Reverse-Proxy" has been uninstalled!"
      else
           echo -e "${RED}error: Failed to uninstall Reverse-Proxy Helm Chart. Return Code: ${retVal}"
           exit 1
      fi

      echo -e "${YELLOW}******Uninstalling Secrets****"
      oc delete secret ibm-dip
      oc delete secret ibmicrio
      oc delete secret ibm-cr
      oc delete secret ibm-login-config
      oc delete secret ibm-login-config-mw


}

function uninstallRbac() {

  echo -e "${YELLOW}*****uninstalling Helm Chart of RBAC*****"
       helm uninstall rbac --namespace ${namespace}
       retVal=$?
       if [ $retVal -eq 0 ]; then
            echo -e "${GREEN}success: Release "rbac" has been uninstalled!"
       else
            echo -e "${RED}error: Failed to uninstall RBAC Helm Chart. Return Code: ${retVal}"
            exit 1
       fi

       echo -e "${YELLOW}*****uninstalling PVC of RBAC*****"
       oc delete pvc rbac-pvc -n ${namespace}
}

function uninstallDIPCodeTransporter() {

     echo -e "${YELLOW}*****uninstalling Helm Chart of Accelerator Services-DIP of version: $version*****"
     echo -e "${YELLOW}*****uninstalling Helm Chart of DIP Code Transporter UI*****"
     helm uninstall dip-code-transporter-ui --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-code-transporter-ui" has been uninstalled!"
     else
          echo -e "${RED}error: Failed to uninstall DIP Code Transporter UI Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****uninstalling Helm Chart of DIP Code Transporter Backend*****"
     helm uninstall dip-code-transporter --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-code-transporter" has been uninstalled!${NOCOLOUR}"
     else
          echo -e "${RED}error: Failed to uninstall DIP Code Transporter Backend Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

}

function uninstallDIPDMB() {

     echo -e "${YELLOW}*****uninstalling Helm Chart of Accelerator Services-DIP of version: $version*****"
     echo -e "${YELLOW}*****uninstalling Helm Chart of Templatized DMB*****"
     helm uninstall dip-templatize-dmb-ui --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-templatize-dmb-ui" has been uninstalled!"
     else
          echo -e "${RED}error: Failed to uninstall Templatized DMB Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****uninstalling Helm Chart of DMB Template Manager UI*****"
     helm uninstall dip-ui-template-manager --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-ui-template-manager" has been uninstalled!"
     else
          echo -e "${RED}error: Failed to uninstall DMB Template Manager UI Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****uninstalling PVC of dip-ui-template-manager*****"
     oc delete pvc dip-common-log-pvc -n ${namespace}

     echo -e "${YELLOW}*****uninstalling Helm Chart of Rest Container*****"
     helm uninstall dip-rest-container --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-rest-container" has been uninstalled!"
     else
          echo -e "${RED}error: Failed to uninstall Rest Container Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****uninstalling PVC of rest-container*****"
     oc delete pvc dmb-generated-code -n ${namespace}
}

function uninstallDIPDSB() {

     echo -e "${YELLOW}*****uninstalling Helm Chart of Accelerator Services-DIP of version: $version*****"
     echo -e "${YELLOW}*****uninstalling Helm Chart of DSB-UI*****"
     helm uninstall dip-dsb-ui --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-dsb-ui" has been uninstalled!"
     else
          echo -e "${RED}error: Failed to uninstall DSB-UI Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}******Deleting Service Account igm4c-sa*****"
     oc delete sa igm4c-sa -n ${namespace}

     echo -e "${YELLOW}*****uninstalling Helm Chart of Event Container*****"
     helm uninstall dip-event-container --namespace ${namespace}
     retVal=$?
     if [ $retVal -eq 0 ]; then
          echo -e "${GREEN}success: Release "dip-event-container" has been uninstalled!"
     else
          echo -e "${RED}error: Failed to uninstall Event Container Helm Chart. Return Code: ${retVal}"
          exit 1
     fi

     echo -e "${YELLOW}*****uninstalling PVC of event-container*****"
     oc delete pvc dsb-generated-code -n ${namespace}

     echo -e "${YELLOW}*****uninstalling PVC of event-container*****"
     oc delete pvc dsb-logs -n ${namespace}

    echo -e "${YELLOW}*****uninstalling Helm Chart of Oneclick*****"
    helm uninstall dip-oneclick --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "dip-oneclick" has been uninstalled!${NOCOLOUR}"
    else
         echo -e "${RED}error: Failed to uninstall Oneclick Helm Chart. Return Code: ${retVal}"
         exit 1
    fi
}

function uninstallCMA() {

    echo -e "${YELLOW}*****uninstalling Helm Chart of Accelerator Services-CMA of version: $version*****"
    echo -e "${YELLOW}*****uninstalling Helm Chart of CMA-BFF*****"
    helm uninstall cma-bff --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "cma-bff" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall CMA-BFF Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling Helm Chart of Microservice-Evaluator*****"
    helm uninstall microservices-evaluator --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "microservices-evaluator" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall Microservice-Evaluator Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling Helm Chart of Microservice-Recommender*****"
    helm uninstall microservice-recommender --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "microservice-recommender" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall Microservice-Recommender Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling Helm Chart of GM4C-MFE-CMA*****"
    helm uninstall gm4c-mfe-app-cma --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "gm4c-mfe-app-cma" has been uninstalled!${NOCOLOUR}"
    else
         echo -e "${RED}error: Failed to uninstall CMA Helm Chart. Return Code: ${retVal}"
         exit 1
    fi
    echo -e "${YELLOW}*****uninstalling PVC of CMA*****"
    oc delete pvc cma-bff-pvc -n ${namespace}
    oc delete pvc cma-bff-ms-recommender-ms-evaluator -n ${namespace}

    if [ oc get deployments gm4c-mfe-app-mam -n ${namespace} &>/dev/null ] || [ oc get deployments gm4c-mfe-app-cti -n ${namespace} &>/dev/null ]; then
      echo "MAM/CTI is installed in project/namespace ${namespace}. NEO4J will not be uninstalled"
      else
          echo -e "${YELLOW}*****uninstalling Helm Chart of NEO4J*****"
          helm uninstall neo4j --namespace ${namespace}
          retVal=$?
          if [ $retVal -eq 0 ]; then
               echo -e "${GREEN}success: Release "neo4j" has been uninstalled!"
          else
               echo -e "${RED}error: Failed to uninstall NEO4J Helm Chart. Return Code: ${retVal}"
               exit 1
          fi

          echo -e "${YELLOW}*****uninstalling PVC of NEO4J*****"
          oc delete pvc data-neo4j-0 -n ${namespace}
    fi

}

function uninstallCTI() {

    echo -e "${YELLOW}*****uninstalling Helm Chart of Accelerator Services-CTI of version: $version*****"
    echo -e "${YELLOW}*****uninstalling Helm Chart of Analytics*****"
    helm uninstall analytics --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "analytics" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall Analytics Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling Helm Chart of Ingestion*****"
    helm uninstall ingestion --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "ingestion" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall Ingestion Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling PVC of analytics*****"
    oc delete pvc dip-common-log-pvc-2 -n ${namespace}

    echo -e "${YELLOW}*****uninstalling PVC of analytics*****"
    oc delete pvc ingestion-pvc -n ${namespace}

    echo -e "${YELLOW}*****uninstalling Helm Chart of GM4C-MFE-CTI*****"
    helm uninstall gm4c-mfe-app-cti --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "gm4c-mfe-app-cti" has been uninstalled!${NOCOLOUR}"
    else
         echo -e "${RED}error: Failed to uninstall GM4C-MFE-CTI Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    if [ oc get deployments gm4c-mfe-app-mam -n ${namespace} &>/dev/null ] || [ oc get deployments gm4c-mfe-app-cma -n ${namespace} &>/dev/null ]; then
      echo "MAM/CMA is installed in project/namespace ${namespace}. NEO4J will not be uninstalled"
      else
          echo -e "${YELLOW}*****uninstalling Helm Chart of NEO4J*****"
          helm uninstall neo4j --namespace ${namespace}
          retVal=$?
          if [ $retVal -eq 0 ]; then
               echo -e "${GREEN}success: Release "neo4j" has been uninstalled!"
          else
               echo -e "${RED}error: Failed to uninstall NEO4J Helm Chart. Return Code: ${retVal}"
               exit 1
          fi

          echo -e "${YELLOW}*****uninstalling PVC of NEO4J*****"
          oc delete pvc data-neo4j-0 -n ${namespace}
    fi

}

function uninstallMAM() {

    echo -e "${YELLOW}*****uninstalling Helm Chart of Accelerator Services-MAM of version: $version*****"

    echo -e "${YELLOW}*****uninstalling Helm Chart of InfluxDB*****"
    helm uninstall influxdb --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "influxdb" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall InfluxDB Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling PVC of influxdb*****"
    oc delete pvc influxdb-data-influxdb-0 -n ${namespace}

    echo -e "${YELLOW}******Deleting Service Account igm4c-sa*****"
    oc delete sa igm4c-sa -n ${namespace}

    echo -e "${YELLOW}*****uninstalling Helm Chart of Data Services*****"
    helm uninstall data-services --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "data-services" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall Data Services Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling Helm Chart of Mainframe-Mod*****"
    helm uninstall mainframe-mod --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "mainframe-mod" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall Mainframe-Mod Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling Helm Chart of MAM-CA*****"
    helm uninstall mam-ca --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "mam-ca" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall MAM-CA Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}*****uninstalling Helm Chart of MAM-OPSKPIS*****"
    helm uninstall mam-opskpis --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "mam-opskpis" has been uninstalled!"
    else
        echo -e "${RED}error: Failed to uninstall MAM-OPSKPIS Helm Chart. Return Code: ${retVal}"
        exit 1
    fi

    echo -e "${YELLOW}*****uninstalling Helm Chart of GM4C-MFE-MAM*****"
    helm uninstall gm4c-mfe-app-mam --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "gm4c-mfe-app-mam" has been uninstalled!${NOCOLOUR}"
    else
         echo -e "${RED}error: Failed to uninstall GM4C-MFE-MAM Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    if [ oc get deployments gm4c-mfe-app-cti -n ${namespace} &>/dev/null ] || [ oc get deployments gm4c-mfe-app-cma -n ${namespace} &>/dev/null ]; then
      echo "CTI/CMA is installed in project/namespace ${namespace}. NEO4J will not be uninstalled"
      else
          echo -e "${YELLOW}*****uninstalling Helm Chart of NEO4J*****"
          helm uninstall neo4j --namespace ${namespace}
          retVal=$?
          if [ $retVal -eq 0 ]; then
               echo -e "${GREEN}success: Release "neo4j" has been uninstalled!"
          else
               echo -e "${RED}error: Failed to uninstall NEO4J Helm Chart. Return Code: ${retVal}"
               exit 1
          fi

          echo -e "${YELLOW}*****uninstalling PVC of NEO4J*****"
          oc delete pvc data-neo4j-0 -n ${namespace}
    fi

}

function uninstallReverseProxy() {

    echo -e "${YELLOW}*****uninstalling Helm Chart of ICCA Reverse Proxy*****"
    helm uninstall icca-reverse-proxy --namespace ${namespace}
    retVal=$?
    if [ $retVal -eq 0 ]; then
         echo -e "${GREEN}success: Release "icca-reverse-proxy" has been uninstalled!"
    else
         echo -e "${RED}error: Failed to uninstall ICCA Reverse Proxy Helm Chart. Return Code: ${retVal}"
         exit 1
    fi

    echo -e "${YELLOW}******Deleting service account igm4c-sa******"
    oc delete sa igm4c-sa -n ${namespace}

    echo -e "${YELLOW}*****uninstalling PVC of cma-bff*****"
    oc delete pvc cma-bff-pvc -n ${namespace}

    echo -e "${YELLOW}*****uninstalling PVC of mainframe-mod*****"
    oc delete pvc mainframe-mod-pvc -n ${namespace}

    echo -e "${YELLOW}*****Deleting namespace and image pull secrets for ${namespace}*****"
    oc delete secret ibmicrio -n ${namespace}
    oc delete secret ibm-dip -n ${namespace}
    oc delete secret ibm-cr -n ${namespace}
    oc delete secret ibm-login-config -n ${namespace}
    oc delete secret ibm-login-config-mw -n ${namespace}
    oc delete secret jenkins-credentials -n ${namespace}
    oc delete secret dip-ui-template-manager-config -n ${namespace}
}
