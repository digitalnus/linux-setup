# Setup and Configuration Instructions
Initial Setup for Linux virtual environment

## Perform updates

1) SSH into the machine
In your local machine, issue the following command:
> *ssh root@ip*
>
where ip is the IP address of your virtual machine
  
2) Update any new packages available
> *apt-get update*
>
> *apt-get upgrade -y*
>
> *apt-get dist-upgrade -y*

## Install Docker and Docker-Compose
Next, install docker and docker-compose  
> *apt install docker.io*
>
> *apt install docker-compose*

## Create non-root user
It is good practice to access the system using a non-root account. Create a new user that you will login into the system with and use *sudo* if you require 
root access.

> *useradd \-m yourusername*
> 
> *usermod \-aG sudo yourusername*
> 
> *usermod \-aG docker yourusername*




