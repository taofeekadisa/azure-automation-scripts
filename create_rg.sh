#!/bin/bash
#CREATE RESOURSE GROUP
#AUTHOR: TAOFEEK ADISA

#READ THE ACCOUNT NAMES INTO A LIST "sub_list"
readarray -t sub_list < <(echo $(az account list --query "[].name"))


#CREATE a VARIABLE TO STORE THE SUBSCRIPTION
SUB_NAME="ADISA Taofeek"

#CHECK ID THE SUBSCRIPTION NAME EXIT ELSE CREATE A NEW ONE

if  [[ "${sub_list[@]}" =~ "$SUB_NAME" ]]
then
	echo $(az account set -s "$SUB_NAME")
	echo -e "\nAccount Set to $SUB_NAME Successfully"
else
	echo "Subscription name does not exit"
fi

#CREATE A RESOURCE GROUP
readarray -t rg_list < <(echo $(az group list --query "[].name"))

#CREATE A VARIABLE "rg_name" and "region_name"
resource_group=hator-dev-rg
region=eastus2
#Tags
Owner=hator-dev
Environment=dev

#CHECK IF THE RESOURCE GROUP EXIST ELSE CREATE A NEW ONE
if [[ "${rg_list[@]}" =~ "$resource_group" ]]
then
	echo "Resource Group exit"
else
	echo $(az group create -l $region -n $resource_group --tags Owner="$Owner"  Environment="$Environment")
fi
