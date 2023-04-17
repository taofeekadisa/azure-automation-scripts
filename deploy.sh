#!/bin/bash
#DEPLOY INFRASTRUCTURE
#AUTHOR : TAOFEEK ADISA

#1. CREATE RESOURCE GROUP
./create_rg.sh
#2. CREATE NETWORK SECURITY GROUP
./create_nsg.sh

#3. CREATE VIRTUAL NETWORK
./create_vn.sh

#4. CREATE PUBLIC IP
./create_pip.sh
#5. CREATE SUBNETS
./create_snet.sh

#6. CREATE NETWORK SECURITY RULES
./create_nsg_rule.sh

#7. CREATE VIRTUAL MACHINES
./create_vm.sh

