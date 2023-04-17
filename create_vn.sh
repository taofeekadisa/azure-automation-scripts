#!/bin/bash

#PROJECT : TO CREATE A VIRTULA NETWORK AND SUBNETS
#AUTHOR :TAOFEEK ADISA

#CREATE ALL VARIABLES
resource_group=hator-dev-rg
region=eastus2
network_name=dev-vn
network_ip=10.0.0.0/16
#Tag
Owner=dev-team
Environment=dev

#Store the network list in a vraiable
readarray -t network_list < <(echo $(az network vnet list -g $resource_group --query "[?location=='$region'].name"))

if [[ "$network_list" =~ "$network_name" ]]
then
	echo "Network Exit"
else
	echo $(az network vnet create -g $resource_group -l $region -n $network_name --address-prefixes $network_ip \
		--tags Owner=$Owner Environment=$Environment)
	echo "Virtual Network Created Succesfully!"
fi
