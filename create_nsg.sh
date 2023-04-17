#!/bin/bash

#PROJECT : CREATE NETWORK SECURITY GROUP
#AUTHOR : TAOFEEK ADISA

#CREATE A VARIABLE TO STORE THE LIST OF NSGs
readarray -t nsg_list < <(echo $(az network nsg list --query "[].name"))

#CREATE A VARIABLE FOR THE NSG NAME, RESOURCE GROUP, REGION
nsg_name=dev-nsg
resource_group=hator-dev-rg
region=eastus2

#CHECK IF THE NSG EXIST BEFORE CREATING

if [[ "$nsg_list" =~ "$nsg_name" ]]
then
	echo "Network Security Group Exist"
else
	echo $(az network nsg create -n $nsg_name -g $resource_group -l $region)
fi
