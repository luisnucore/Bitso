if [[ $EUID -eq 0 ]]; then
    echo "Deployin' Bitso Challenge on CentOS/RedHat 7 \n \n"
    echo "Please Prvide the AWS Access Key ID"
    read keyid
    echo "Please Prvide the AWS Access Key"
    read key
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
    mkdir /opt/bitsochallenge
    cd /opt/bitsochallenge
    git clone https://github.com/luisnucore/Bitso
    export AWSACCESS_KEY_ID=$keyid
    export AWSSECRET_ACCESS_KEY=$key
    cd ./Bitso
    terraform init
    if [ $? -ne 0 ] ; then
      echo "Please verify your credentials and try again"
      exit 1
    fi
    terraform apply -var  --auto-approve  "id=$AWSACCESS_KEY_ID"   -var "key=$AWSSECRET_ACCESS_KEY"
    echo "The Infrastructure has been depployed in AWS Oregon region, check your AWS console"
else
  echo "This script must be run as root"
  exit 1
fi
