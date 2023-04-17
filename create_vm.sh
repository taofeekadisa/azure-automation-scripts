#!/bin/bash

#PROJECT : TO CREATE VIRTUAL MACHINES
#AUTHOR :TAOFEEK ADISA

#MAKE A LIST OF THE PUBLIC IP ADDRESS IN HATOR-DEV-RG
my_list=()

while read -r ip
do
       	my_list+=("$ip")
done < <(az network public-ip list -g hator-dev-rg --query "[?name=='dev-ip'].ipAddress")
ip=${my_list[1]}
IP=${ip//\"/}

#CREATE ALL VARIABLES
resource_group=hator-dev-rg
region=eastus2
nsg=dev-nsg
vnet=dev-vn
vnet_address=10.0.0.0/16
vm_image=UbuntuLTS
vm_size=Standard_B1s
zone=1
username=adminuser
password="Knixat@12345"

#WEB VERITUAL MACHINE
vm1=web-vm
subnet1=dev-web-snet
subnet1_ip=10.0.0.0/24
ip_name=dev-ip
public_ip=$IP

#API VIRTUAL MACHINE
vm2=api-vm
subnet2=dev-api-snet
subnet2_ip=10.0.1.0/24

#DATABASE VIRTUAL MACHINE
vm3=db-vm
subnet3=dev-db-snet
subnet3_ip=10.0.2.0/24

#Store the virtual machines list in a variable
readarray -t vm_list < <(echo $(az vm list -g hator-dev-rg --query "[?location=='eastus2'].name"))

#CREATE WEB VIRUAL MACHINE
if [[ "$vm_list" =~ "$vm1" ]]
then
	echo "$vm1 Exit"
else
	echo $(az vm create -n $vm1 -g $resource_group -l $region --nsg $nsg --image $vm_image --size $vm_size --subnet $subnet1 \
		--subnet-address-prefix $subnet1_ip  --public-ip-address $public_ip --vnet-name $vnet --vnet-address-prefix $vnet_address \
		--zone $zone --admin-username $username --admin-password $password)
	echo "Web Server Created Successfully!"
fi	

#CREATE THE API VIRTUAL MACHINE
if [[ "$vm_list" =~ "$vm2" ]]
then
       	echo "$vm1 Exit"
else
       	echo $(az vm create -n $vm2 -g $resource_group -l $region --nsg $nsg --image $vm_image --size $vm_size --subnet $subnet2 \
		 --subnet-address-prefix $subnet2_ip  --vnet-name $vnet --vnet-address-prefix $vnet_address \
		 --zone $zone --admin-username $username --admin-password $password)
	 echo "API Server Created Successfully!"
fi

#CREATE THE DATABASE VIRTUAL MACHINE
if [[ "$vm_list" =~ "$vm2" ]]
then
       	echo "$vm1 Exit"
else
	echo $(az vm create -n $vm3 -g $resource_group -l $region --nsg $nsg --image $vm_image --size $vm_size --subnet $subnet3 \
		 --subnet-address-prefix $subnet3_ip  --vnet-name $vnet --vnet-address-prefix $vnet_address \
		 --zone $zone --admin-username $username --admin-password $password)
	echo "Database Server Created Successfully!"
fi
