# BitsoChallenge

## Prerequisites:
 - CentOS 7
 - AWS Acces Key ID
 - AWS Acces Key
 - AWS ssh keyname of the ".pem" you want to install in the EC2 instance

## Execution
  1.- Access your CentOS Server via CLI as root user
  2.- Install wget using the next command
  *yum install -y wget*
  3.- Copy and Paste the next line in the CLI
  *wget https://raw.githubusercontent.com/luisnucore/Bitso/master/deploy.sh; chmod 700 deploy.sh; ./deploy.sh*
  4.- Provide the Information requested by the script
  5.- Done
