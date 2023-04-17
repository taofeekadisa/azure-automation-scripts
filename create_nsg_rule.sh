#!/bin/bash
#PROJECT : CREATE THE INBOUND & OUTBOUND NETWORK SECURITY GROUP RULES
#AUTHOR :TAOFEEK ADISA

#CREATE VARIABLES
resource_group=hator-dev-rg
nsg_name=dev-nsg
web_ip=10.0.0.0/24
api_ip=10.0.1.0/24
db_ip=10.0.2.0/24

#IBOUND SECURITY RULES
#Rule 1.Allow port 80 over the internet to the Web Subnet (10.0.0.0/24).
az network nsg rule create -n rule1 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 100 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes '*' --destination-port-ranges 80 --destination-address-prefixes $web_ip --access Allow \
	--description "AllowanyHTTPInboundtoWebServer"

#Rule 2.Allow port 22 from any to Web Subnet.
az network nsg rule create -n rule2 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 120 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes '*' --destination-port-ranges 22 --destination-address-prefixes $web_ip --access Allow \
	--description "AllowanySSHInboundtoWebServer"

#Rule 3.Allow port 22 from Web Subnet to API Subnet.
az network nsg rule create -n rule3 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 140 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes $web_ip  --destination-port-ranges 22 --destination-address-prefixes $api_ip --access Allow \
	--description "AllowWebServerSSHInboundtoAPIServer"

#Rule 4.Allow port 22 from API Subnet to DB Subnet.
az network nsg rule create -n rule4 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 160 --protocol Tcp --source-port-ranges '*' \
	 --source-address-prefixes $api_ip  --destination-port-ranges 22 --destination-address-prefixes $db_ip --access Allow \
	 --description "AllowAPIServerSSHInboundtoDBServer"

#Rule 5.Deny port 22 from Web Subnet to DB Subnet.
az network nsg rule create -n rule5 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 180 --protocol Tcp --source-port-ranges '*' \
	 --source-address-prefixes $web_ip  --destination-port-ranges 22 --destination-address-prefixes $db_ip --access Deny \
	 --description "DenyWebServerSSHInboundtoDBServer"

#Rule 6.Deny port 80 from internet to API Subnet (10.0.1.0/24).
az network nsg rule create -n rule6 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 200 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes '*'  --destination-port-ranges 80 --destination-address-prefixes $api_ip --access Deny \
	--description "DenyanyHTTPInboundtoAPIServer"

#Rule 7.Deny port 80 from internet to DB Subnet (10.0.2.0/24).
az network nsg rule create -n rule7 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 220 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes '*'  --destination-port-ranges 80 --destination-address-prefixes $db_ip --access Deny \
	--description "DenyanyHTTPInboundtoDBServer"

#Rule 8.Allow port 80 from Web Subnet to API Subnet.
az network nsg rule create -n rule8 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 240 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes $web_ip  --destination-port-ranges 80 --destination-address-prefixes $api_ip --access Allow \
	--description "AllowWebServerHTTPInboundtoAPIServer"

#Rule 9.Allow port 80 API Subnet to DB Subnet.
az network nsg rule create -n rule9 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 260 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes $api_ip  --destination-port-ranges 80 --destination-address-prefixes $db_ip --access Allow \
	--description "AllowAPIServerHTTPInboundtoDBServer"

#Rule 10.Deny port 80 from Web Subnet to DB Subnet.
az network nsg rule create -n rule10 --nsg-name $nsg_name -g $resource_group --direction Inbound --priority 280 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes $web_ip  --destination-port-ranges 80 --destination-address-prefixes $db_ip --access Deny \
	--description "DenyWebServerHTTPInboundtoDBServer"


#OUTBOUND SECURITY RULES
#Rule 11.Allow port 80 from API Subnet to Web Subnet.
az network nsg rule create -n rule11 --nsg-name $nsg_name -g $resource_group --direction Outbound --priority 300 --protocol Tcp --source-port-ranges '*' \
	 --source-address-prefixes $api_ip  --destination-port-ranges 80 --destination-address-prefixes $web_ip --access Allow \
	  --description "AllowAPIServerHTTPInboundtoWebServer"

#Rule 12.Allow port 80 from DB Subnet to API Subnet.
az network nsg rule create -n rule12 --nsg-name $nsg_name -g $resource_group --direction Outbound --priority 320 --protocol Tcp --source-port-ranges '*' \
	--source-address-prefixes $db_ip  --destination-port-ranges 80 --destination-address-prefixes $api_ip --access Allow \
	--description "AllowDBServerHTTPInboundtoAPIServer"

#Rule 13.Deny port 80 from DB Subnet to Web Subnet.
az network nsg rule create -n rule13 --nsg-name $nsg_name -g $resource_group --direction Outbound --priority 340 --protocol Tcp --source-port-ranges '*' \
	 --source-address-prefixes $db_ip  --destination-port-ranges 80 --destination-address-prefixes $web_ip --access Deny \
	  --description "DenyDBServerHTTPInboundtoWebServer"

