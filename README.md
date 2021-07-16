# Setup and Configuration Instructions
Initial Setup for Linux virtual server and steps to secure access to it.

## 1) Setup at local machine
This section describes the generation of ssh keypair which will be used
for connecting your computer to the remote machine

### 1.1 - Create folder for storing ssh keypair
Note: You might have already have the .ssh folder so the step 1.1 will not apply to you.
Alternatively, you can also create another folder to store the keypair which you will generate subsequently.

> *mkdir ~/.ssh*
>
> *cd ~/.ssh*

### 1.2 - Generate the ssh keypair
> *ssh-keygen  -b 4096 -t rsa -f ./id_sample_rsa -C "Sample keypair"*

Replace the id_sample_rsa filename with your own

-C is optional, you can choose not to specify it

```
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in ./id_sample_rsa.
Your public key has been saved in ./id_sample_rsa.pub.
The key fingerprint is:
SHA256:p36PqXiHFH+pY5eWTYnxJj+5k/FwvxaNG5SVazSAXck Sample keypair
The key's randomart image is:
+---[RSA 4096]----+
|            o.+.o|
|           . . E.|
|              .oo|
|        .   . oo |
|        So.  *.o.|
|        .o. = X.o|
|       ... o O Xo|
|       oo *o= O.o|
|      ..o=o=. o=.|
+----[SHA256]-----+
```

### 1.3 - Verify the generated keypair
This step is optional, it is just to verify that your keypair was generated successfully.

>*ssh-keygen -f id_sample_rsa.pub -l*

Output will look similar to this
```
4096 SHA256:p36PqXiHFH+pY5eWTYnxJj+5k/FwvxaNG5SVazSAXck Sample keypair (RSA)
```

### 1.4 - Copy your public key to remote server
This step will copy your public key (the one with .pub file extension) to your remote server.

Note: It is important that you do not share your private key (in this example, it is id_sample_rsa) to anyone and keep it in your own computer.

First, find out what is the IP address of your remote computer. You can get find out from your hosting provider, this information was given to you when
you provision your server in the hosting platform.

Issue the following command to copy your public key over to your remote server:

>*ssh-copy-id -i ./id_sample_rsa.pub root@104.200.35.113*

Note: Replace the IP address with your actual server IP address and very importantly, the file that you are copying over should be the public key (ending with .pub) and NOT the private key!

```
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "./id_sample_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@104.200.35.113's password: 
```

Enter the password of the root user account, once done, your file will be copied over to the server and we can proceed on to the next step on setting up
your remote machine.



## 2) Setup at remote machine
The following section is performed at the remote machine.
For example, digital ocean or linode etc.

### 2.1 - Perform updates

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

3) Install other tools
> *apt install net-tools -y*


### 2.2 - Create non-root user
It is good practice to access the system using a non-root account. 
Create a new user that you will login into the system with and use *sudo* if you require 
root access.

> *useradd \-m yourusername*
> 
> *usermod \-aG sudo yourusername*
> 
> *usermod \-aG docker yourusername*


### 2.3 - Secure your login access
As root account contains the highest privileges, you want to restrict the use of this account only when required.
In this section, you will secure your server by enforcing login using ssh certificate only and disabling login using the root user account.

Clone the sshd_config file in this repo and copy it to /etc/ssh/ directory.

Restart the sshd daemon with the following command:

> *sudo systemctl reload ssh*

Open another terminal and test that you cannot login directly using root account anymore and the only way you can login to your server
is by using the ssh key and non-root user which you have created in the previous step.

> *ssh -i ./id_sample_rsa yourusername@ip-addr*

Replace yourusername and ip-addr with the actual username and IP address of your server.

Congratulations, you have now secured access to your server! This is just the first step. In subsequent documents, it will cover additional setups such as configuring firewalls to beef up the security of your setup.



### 2.4 - Other Non-security related setups
This section will perform additional setups, not security-related, you can choose to skip it.

Change your login shell to bash:
> *sudo chsh -s /bin/bash yourusername*

If your user account was created using /bin/sh, you might discover that things like your up/down arrow etc will not be functioning.
The above command will change it to /bin/bash and you either need to log out and into your account again or run the .bashrc to have the changes take effect.


Next, install docker and docker-compose. Docker will enable you to deploy applications such as web servers, databases and Wordpress easily.
I will recommend that you install them and better manage your deployments.

To install docker and docker-compose, issue the following commands:

> *apt install docker.io*
>
> *apt install docker-compose*




