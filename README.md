# Capstone-green-blue-deploy-minikube | DevOps Engineer Nanodegree
This is a Simple blue-green deployment in kubernetes using minikube, Capstone project, Cloud DevOps Nanodegree.

## objectives
Redirect traffic from the blue container to the green container.

## Requirements for running Jenkins Pipeline
For running Jenkins Pipeline, you will need to install Jenkins on your local machine, or (in this case as I used) an Amazon EC2 instance. 
1. Create your own EC2 instance, by login into Amazon AWS console. Here's a series of steps required to set up your own EC2 instance: https://portal.aws.amazon.com/billing/signup#/start 
Use a Ubuntu 18 with T2.micro since this is included in Free Tier from Amazon.
Once launched, create a security group for the vm. In the left sidebar, under Network and Security, select "Security Groups." Under name, use: 'jenkins', description: "basic Jenkins security group," VPC should have the default one used. Click Add Rule: Custom TCP Rule, Protocol: TCP, Port Range 8080, Source 0.0.0.0/0 Then add the SSH rule: Protocol: SSH, Port range: 22, From source, use the dropdown and select "My IP." See infra.yml



2. Now connect to your EC2 istance by following steps, written on following link: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Connect-using-EC2-Instance-Connect.html

3. Prepare and install Jenkins on Ubuntu EC2 instance: 
```
$ apt update
$ apt upgrade
$ apt install default-jdk
$ wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
$ sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
$ sudo apt update
$ sudo apt install jenkins
$ sudo systemctl status jenkins
```
After running the above commands, you should status of Jenkins instance, running on your EC2 instance or local machine.

4. Jenkins by defualt runs on port 8080. So, Visit Jenkins on its default port, 8080.

5. Now run the following command, and copy the password generated. Put this password in Jenkins login screen.
```
$ sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

6. (Optional) Create an user. When installation is complete, you are prompted to set up the first admin user. 

## Install recommended plugins as Blueu Ocean, pipeline-aws.

Once all plugins are installed, Jenkins will restart. If it hasn't restarted, run the following in the VM:
```
sudo systemctl restart jenkins
```
Verify Installation
