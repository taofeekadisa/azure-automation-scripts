#!/bin/bash
#CREATE RESOURSE GROUP
#AUTHOR: TAOFEEK ADISA

#READ THE ACCOUNT NAMES INTO A LIST "sub_list"
readarray -t sub_list < <(echo $(az account list --query "[].name"))

#CREATE A VARIABLE "subscription_name"
sub_name1="Enter your subscription name"

#CREATE AN INPUT FUNCTION TO ALLOW USER ENTER A SUBSCRIPTION NAME
echo -e "\n $sub_name1"
read SUB_NAME

#CHECK ID THE SUBSCRIPTION NAME EXIT ELSE CREATE A NEW ONE

if  [[ "${sub_list[@]}" =~ "$SUB_NAME" ]]
then
	echo $(az account set -s "$SUB_NAME")
else
	echo "Subscription name does not exit"
fi

#CREATE A RESOURCE GROUP
readarray -t rg_list < <(echo $(az group list --query "[].name"))

#CREATE A VARIABLE "rg_name" and "region_name"
rg_name="Enter Resource Group name"
region_name="Enter Region name"
echo -e "\n$rg_name"
read resource_group

echo -e "\n$region_name"
read region

#CHECK IF THE RESOURCE GROUP EXIST ELSE CREATE A NEW ONE
if [[ "${rg_list[@]}" =~ "$resource_group" ]]
then
	echo "Resource Group exit"
else
	echo $(az group create -l $region -n $resource_group)
fi
