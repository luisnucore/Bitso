# Example Deploying in AWS from terraform
In this example scripts, we depoy a EC2 instance and RDS instance y AWS

## Prerequisites:
 - CentOS 7
 - AWS Acces Key ID
 - AWS Acces Key
 - AWS ssh keyname of the ".pem" you want to install in the EC2 instance

## Execution
  - 1.- Access your CentOS via CLI as root user
  - 2.- Install wget using the next command  
    *yum install -y wget*
  - 3.- Copy and Paste the next line in the CLI  
   *wget https://raw.githubusercontent.com/luisnucore/Bitso/master/deploy.sh; chmod 700 deploy.sh; ./deploy.sh*
  - 4.- Provide the Information requested by the script
  - 5.- Done  



### NOTES:
  - This Instructions work only using a CentOS 7, you can try to execute it in "RedHat Like" OS under no warranty  
  - If you are familiar with terraform, you can clone the repository and execute the ".tf" files
  - In the file: execution-output.txt, you can find an example output when we execute the intructions above 
