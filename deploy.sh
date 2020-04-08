#!/bin/bash
if [[ $EUID -eq 0 ]]; then
    echo "Deployin' Bitso Challenge on CentOS/RedHat 7 \n \n"
    echo "Please Provide the AWS Access Key ID"
    read keyid
    echo "Please Provide the AWS Access Key"
    read key
    echo "Please Provide the ssh keyname to be installed in the EC2 instance"
    read keynom
    exists=$( find / -name terraform 2>&1 | xargs file 2>&1 | grep executable 2>&1 | cut -d ':' -f1 )
    echo $PATH | grep $(dirname $exists) >/dev/null 2>/dev/null
    if [ $? = 0 ] ; then
      echo "Terraform is already installed"
    else
      echo "Terraform is not installed, We'll proceed to install it"
      yum install -y wget unzip
      wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
      unzip ./terraform_0.11.13_linux_amd64.zip -d /usr/local/bin/
      terraform -v
    fi
    echo "installing Git"
    yum install -y git
    mkdir /opt/bitsochallenge
    cd /opt/bitsochallenge
    git clone https://github.com/luisnucore/Bitso
    echo "export AWSACCESS_KEY_ID=$keyid" >> ~/.bash_profile
    echo "export AWSSECRET_ACCESS_KEY=$key" >> ~/.bash_profile
    . ~/.bash_profile
    cd ./Bitso
    terraform init
    if [ $? -ne 0 ] ; then
      echo "Please verify your credentials and try again"
      exit 1
    fi
    terraform plan  -var "id=$AWSACCESS_KEY_ID"   -var "key=$AWSSECRET_ACCESS_KEY" -var "keyname=$keynom"
    terraform apply --auto-approve  -var "id=$AWSACCESS_KEY_ID"   -var "key=$AWSSECRET_ACCESS_KEY" -var "keyname=$keynom"

    echo "The Scrips used to deploy this infrastrucure is located at /opt/bitsochallenge/Bitso/ in this OS"
    echo "The Infrastructure has been deployed in AWS, region Oregon, check your AWS console ;)"
    echo "Now you can go ahead and type the in your webbrowser http://$(terraform output instance_ips)"
    echo "you can also access via ssh to the EC2 instance using ssh -i <key.pem> ubuntu@$(terraform output instance_ips)"
else
  echo "This script must be run as root"
  exit 1
fi
