#!/bin/bash

#PROJECT : CREATE A PUBLIC IP FOR THE WEB SERVER
#AUTHOR :TAOFEEK ADISA

#CREATE A VARIABLE TO STORE THE LIST OF PUBLIC IPs
readarray -t myIP < <(echo $(az network public-ip list --query "[].name"))

#CREATE VARIABLES
ip_name=dev-ip
rg_name=hator-dev-rg
region=eastus2
allocation_method=static
version=ipv4
#Tags
Environment=dev

#CHECK IF THE IP EXIST

if [[ "$myIp" =~ "$ip_name" ]]
then
	echo "IP Already Exist"
else
	echo $(az network public-ip create -n $ip_name -g $rg_name -l $region --allocation-method $allocation_method --version $version --tags Environemnt=$Environment)
fi
