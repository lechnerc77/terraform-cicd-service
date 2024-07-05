#!/bin/bash
echo "+++++++++++++++++++++++++++"
echo "+ Executing Terraform plan"
echo "+++++++++++++++++++++++++++"

export BTP_USERNAME=$btpauthentication_user
export BTP_PASSWORD=$btpauthentication_password

echo $btpauthentication_user
echo $btpauthentication_password
echo $globalaccountsubdomain

./tools/terraform -chdir="setup_subaccount" init
./tools/terraform -chdir="setup_subaccount" plan -var globalaccount=$globalaccountsubdomain -no-color
