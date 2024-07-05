#!/bin/bash
echo "+++++++++++++++++++++++++++"
echo "+ Executing Terraform plan"
echo "+++++++++++++++++++++++++++"

#export BTP_USERNAME=$btp-authentication_user
#export BTP_PASSWORD=$btp-authentication_password

./tools/terraform --help

#./tools/terraform -chdir="setup_subaccount" init
#./tools/terraform -chdir="setup_subaccount" plan -var globalaccount=$globalaccount-subdomain
