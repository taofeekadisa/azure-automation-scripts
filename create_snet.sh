#!/bin/bash

#PROJECT : TO CREATE SUBNETS
#AUTHOR :TAOFEEK ADISA

#CREATE ALL VARIABLES
resource_group=hator-dev-rg
#region=eastus2
nsg=dev-nsg
vnet=dev-vn
subnet1=dev-web-snet
subnet1_ip=10.0.0.0/24
subnet2=dev-api-snet
subnet2_ip=10.0.1.0/24
subnet3=dev-db-snet
subnet3_ip=10.0.2.0/24

#Store the subnets list in a variable
readarray -t snet_list < <(echo $(az network vnet subnet list -g hator-dev-rg --vnet-name dev-vn --query "[].name"))

#CREATE WEB SUBNET
if [[ "$snet_list" =~ "$subnet1" ]]
then
	echo "$subnet1 Exit"
else
	echo $(az network vnet subnet create -n $subnet1 -g $resource_group --vnet-name $vnet --network-security-group $nsg --address-prefixes $subnet1_ip)
	echo "$subnet1 Created Succesfully!"
fi

#CREATE API SUBNET
if [[ "$snet_list" =~ "$subnet1" ]]
then
       	echo "$subnet2 Exit"
else
       	echo $(az network vnet subnet create -n $subnet2 -g $resource_group --vnet-name $vnet --network-security-group $nsg --address-prefixes $subnet2_ip)
       	echo "$subnet2 Created Succesfully!"
fi

#CREATE DATABASE SUBNET
if [[ "$snet_list" =~ "$subnet1" ]]
then
       	echo "$subnet3 Exit"
else
       	echo $(az network vnet subnet create -n $subnet3 -g $resource_group --vnet-name $vnet --network-security-group $nsg --address-prefixes $subnet3_ip)
       	echo "$subnet3 Created Succesfully!"
fi
