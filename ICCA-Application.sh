#!/bin/bash

source icca.properties
source install-HelmCharts.sh
source uninstall-HelmCharts.sh
source install-ReverseProxy.sh
source install-PreRequisites.sh

#Instructoins to install all the services
function InstallAllServices() {
    echo "Installing all the services ICCA Core, ICCA Solution Design, Code Transporter, DMB, DSB, CMA, CTI and MAM"
    #Install Pre-requisites required for installation of services
    preReqICCACore
    preReqDIPDMB
    preReqDIPDSB
    preReqCMA
    preReqCTI
    preReqMAM
    #Install ICCA Services
    ICCACore
    dipCodeTransporter
    dipDMB
    dipDSB
    CMA
    CTI
    MAM
    #Add Services To Reverse Proxy
    ICCACoreServices
    dipCodeTransporterServices
    dipDMBServices
    dipDSBServices
    cmaServices
    ctiServices
    mamServices
    #Install Reverse Proxy
    reverseProxy
}

#Instructoins to uninstall all the services
function uninstallAllServices() {
    uninstallICCACore
    uninstallDIPCodeTransporter
    uninstallDIPDMB
    uninstallDIPDSB
    uninstallCMA
    uninstallCTI
    uninstallMAM
    uninstallReverseProxy
}


#Prompt the user for input
echo "Welcome to the IBM ICCA!"
while true; do
    echo "Please choose the option:"
    echo "1. Install ICCA Services"
    echo "2. Uninstall ICCA Services"
    echo "3. Quit"

    read -p "Enter your choice (1/2/3): " choice

    case $choice in
        1)
            echo "You selected Option To Install ICCA Services."
            # Provide further choices for Option 1
            echo "Please choose services to be installed:"
            echo "1. Install CMA"
            echo "2. Install CT"
            echo "3. Install CTI"
            echo "4. Install DMB"
            echo "5. Install DSB"
            echo "6. Install MAM"
            echo "7. Install All Services"
            echo "0. Previous Menu"
            read -p "Enter your choice (1/2/3/4/5/6/7/0): " sub_choice
            #Check the user's input and install the corresponding  services
             case $sub_choice in

                  1)
                       if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                         echo "ICCA is installed in project/namespace ${namespace}."
                       else
                         echo "ICCA does not exist in project/namespace ${namespace}. Installing ICCA first."
                         #Install Pre-Requisites
                         preReqICCACore
                         #Install ICCA Services
                         ICCACore
                         #Add Services To Reverse Proxy
                         ICCACoreServices
                         #Install Reverse Proxy
                         reverseProxy
                       fi
                       #Install Pre-Requisites
                       preReqCMA
                       #Install CMA Services
                       CMA
                       #Add Services To Reverse Proxy
                       cmaServices
                       #Install Reverse Proxy
                       reverseProxy
                       ;;

                  2)
                       if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                          echo "ICCA is installed in project/namespace ${namespace}."
                       else
                          echo "ICCA does not exist in project/namespace ${namespace}. Install ICCA first."
                          #Install Pre-Requisites
                          preReqICCACore
                          #Install ICCA Services
                          ICCACore
                          #Add Services To Reverse Proxy
                          ICCACoreServices
                          #Install Reverse Proxy
                          reverseProxy
                       fi
                          dipCodeTransporter
                          #Add Services To Reverse Proxy
                          dipCodeTransporterServices
                          #Install Reverse Proxy
                          reverseProxy
                       ;;

                  3)
                       if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                          echo "ICCA is installed in project/namespace ${namespace}."
                       else
                          echo "ICCA does not exist in project/namespace ${namespace}. Install ICCA first."
                          #Install Pre-Requisites
                          preReqICCACore
                          #Install ICCA Services
                          ICCACore
                          #Add Services To Reverse Proxy
                          ICCACoreServices
                          #Install Reverse Proxy
                          reverseProxy
                       fi
                          #Install Pre-Requisites
                          preReqCTI
                          #Install CTI Services
                          CTI
                          #Add Services To Reverse Proxy
                          ctiServices
                          #Install Reverse Proxy
                          reverseProxy
                       ;;

                  4)
                       if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                           echo "ICCA is installed in project/namespace ${namespace}."
                       else
                           echo "ICCA does not exist in project/namespace ${namespace}. Install ICCA first."
                           #Install Pre-Requisites
                           preReqICCACore
                           #Install ICCA Services
                           ICCACore
                           #Add Services To Reverse Proxy
                           ICCACoreServices
                           #Install Reverse Proxy
                           reverseProxy
                       fi
                           #Install Pre-Requisite
                           preReqDIPDMB
                           #Install DMB Services
                           dipDMB
                           #Add Services To Reverse Proxy
                           dipDMBServices
                           #Install Reverse Proxy
                           reverseProxy
                       ;;
                  5)
                       if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                           echo "ICCA is installed in project/namespace ${namespace}."
                       else
                           echo "ICCA does not exist in project/namespace ${namespace}. Install ICCA first."
                           #Install Pre-Requisites
                           preReqICCACore
                           #Install ICCA Services
                           ICCACore
                           #Add Services To Reverse Proxy
                           ICCACoreServices
                           #Install Reverse Proxy
                           reverseProxy
                       fi
                           #Install Pre-Requisite
                           preReqDIPDSB
                           #Install DSB Services
                           dipDSB
                           #Add Services To Reverse Proxy
                           dipDSBServices
                           #Install Reverse Proxy
                          reverseProxy
                       ;;

                  6)
                       if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                           echo "ICCA is installed in project/namespace ${namespace}."
                       else
                           echo "ICCA does not exist in project/namespace ${namespace}. Install ICCA first."
                           #Install Pre-Requisites
                           preReqICCACore
                           #Install ICCA Services
                           ICCACore
                           #Add Services To Reverse Proxy
                           ICCACoreServices
                           #Install Reverse Proxy
                           reverseProxy
                       fi
                           #Install Pre-Requisites
                           preReqMAM
                           #Install MAM Services
                           MAM
                           #Add Services To Reverse Proxy
                           mamServices
                           #Install Reverse Proxy
                           reverseProxy
                       ;;

                  7)
                       InstallAllServices
                       ;;
                  *)
                       echo "Invalid choice. Please choose 1, 2, 3, 4, 5, 6, 7, 8 or 0"
                       ;;
             esac
             ;;
        2)
            echo "You selected Option To Uninstall ICCA Services."
            # Provide further choices for Option 2
            echo "Please choose services to be installed:"
            echo "1. Uninstall CMA"
            echo "2. Uninstall CT"
            echo "3. Uninstall CTI"
            echo "4. Uninstall DMB"
            echo "5. Uninstall DSB"
            echo "6. Uninstall MAM"
            echo "7. Uninstall RBAC"
            echo "8. Uninstall All Services"
            echo "0. Previous Menu"
            read -p "Enter your choice (1/2/3/4/5/6/7/0): " sub_choice
            case $sub_choice in
                1)
                     if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                        echo "ICCA is installed in project/namespace ${namespace}."
                        while true; do
                          read -p "Do you want to uninstall ICCA ? Enter no to only remove this specific asset and keep ICCA if you have any other assets installed (yes/no): " nested_choice
                          if [ "$nested_choice" = "yes" ]; then
                              echo "Uninstalling ICCA and CMA in project/namespace ${namespace}"
                              uninstallICCACore
                              uninstallCMA
                          elif [ "$nested_choice" = "no" ]; then
                              echo "Uninstalling CMA in project/namespace ${namespace}"
                              uninstallCMA

                          else
                              echo "Invalid choice. Please enter 'yes' or 'no'."
                          fi
                          break
                          done
                    fi
                    ;;

                2)
                     if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                        echo "ICCA is installed in project/namespace ${namespace}."
                        while true; do
                           read -p "Do you want to uninstall ICCA ? Enter no to only remove this specific asset and keep ICCA if you have any other assets installed (yes/no): " nested_choice
                           if [ "$nested_choice" = "yes" ]; then
                                 echo "Uninstalling ICCA and Code Transporter in project/namespace ${namespace}"
                                 uninstallICCACore
                                 uninstallDIPCodeTransporter
                           elif [ "$nested_choice" = "no" ]; then
                                  echo "Uninstalling Code Transporter in project/namespace ${namespace}"
                                  uninstallDIPCodeTransporter

                           else
                                  echo "Invalid choice. Please enter 'yes' or 'no'."
                           fi
                           break
                           done
                     fi
                     ;;

                3)
                     if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                        echo "ICCA is installed in project/namespace ${namespace}."
                        while true; do
                           read -p "Do you want to uninstall ICCA ? Enter no to only remove this specific asset and keep ICCA if you have any other assets installed (yes/no): " nested_choice
                           if [ "$nested_choice" = "yes" ]; then
                               echo "Uninstalling ICCA and CTI in project/namespace ${namespace}"
                               uninstallICCACore
                               uninstallCTI
                           elif [ "$nested_choice" = "no" ]; then
                               echo "Uninstalling CTI in project/namespace ${namespace}"
                               uninstallCTI
                           else
                               echo "Invalid choice. Please enter 'yes' or 'no'."
                           fi
                           break
                           done
                    fi
                    ;;

                   4)

                      if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                         echo "ICCA is installed in project/namespace ${namespace}."
                         while true; do
                            read -p "Do you want to uninstall ICCA ? Enter no to only remove this specific asset and keep ICCA if you have any other assets installed (yes/no): " nested_choice
                            if [ "$nested_choice" = "yes" ]; then
                                 echo "Uninstalling ICCA and DMB in project/namespace ${namespace}"
                                 uninstallICCACore
                                 uninstallDIPDMB
                            elif [ "$nested_choice" = "no" ]; then
                                 echo "Uninstalling DMB in project/namespace ${namespace}"
                                 uninstallDIPDMB

                            else
                                echo "Invalid choice. Please enter 'yes' or 'no'."
                            fi
                            break
                         done
                     fi
                     ;;

                   5)

                      if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                         echo "ICCA is installed in project/namespace ${namespace}."
                         while true; do
                            read -p "Do you want to uninstall ICCA ? Enter no to only remove this specific asset and keep ICCA if you have any other assets installed (yes/no): " nested_choice
                            if [ "$nested_choice" = "yes" ]; then
                                  echo "Uninstalling ICCA and DSB in project/namespace ${namespace}"
                                  uninstallICCACore
                                  uninstallDIPDSB
                            elif [ "$nested_choice" = "no" ]; then
                                    echo "Uninstalling DSB in project/namespace ${namespace}"
                                    uninstallDIPDSB
                                    break
                            else
                                    echo "Invalid choice. Please enter 'yes' or 'no'."
                            fi
                            done
                      fi
                      ;;

                   6)

                      if oc get deployment icca-mw-middleware -n ${namespace} &>/dev/null; then
                         echo "ICCA is installed in project/namespace ${namespace}."
                         while true; do
                            read -p "Do you want to uninstall ICCA ? Enter no to only remove this specific asset and keep ICCA if you have any other assets installed (yes/no): " nested_choice
                            if [ "$nested_choice" = "yes" ]; then
                               echo "Uninstalling ICCA and MAM in project/namespace ${namespace}"
                               uninstallICCACore
                               uninstallMAM
                           elif [ "$nested_choice" = "no" ]; then
                               echo "Uninstalling MAM in project/namespace ${namespace}"
                               uninstallMAM

                           else
                               echo "Invalid choice. Please enter 'yes' or 'no'."
                           fi
                           break
                           done
                      fi
                      ;;

                   7)

                     if oc get deployment rbac -n ${namespace} &>/dev/null; then
                        echo "RBAC is installed in project/namespace ${namespace}."
                        while true; do
                           read -p "RBAC is still required for CMA, CTI and MAM. Do you still want to uninstall RBAC yes or no? (yes/no): " nested_choice
                           if [ "$nested_choice" = "yes" ]; then
                              echo "Uninstalling RBAC in project/namespace ${namespace}"
                              uninstallRbac
                          else
                              echo "Invalid choice. Please enter 'yes' or 'no'."
                          fi
                          break
                          done
                     fi
                     ;;

                   8)
                     uninstallAllServices
                     ;;

                   *)
                     echo "Invalid choice. Please choose 1, 2, 3, 4, 5, 6, 7, 8 or 0"
                     ;;
                esac
                ;;
        3)
            echo "Thank You for trying out ICCA !"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select a valid option (1/2/3)."
            ;;
    esac
done
