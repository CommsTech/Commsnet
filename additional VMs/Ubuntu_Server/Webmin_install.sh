#!bash
#Installing Webmin on Ubuntu
#Webmin is not included in the standard Ubuntu repositories. The installation is a pretty straightforward process. We’ll enable the Webmin repository and install the package with apt .
#The steps below describe the process of installing Webmin on Ubuntu:
#First, update the packages list and install the dependencies:

sudo apt update
sudo apt install software-properties-common apt-transport-https wget
#Import the Webmin GPG key and add the Webmin repository to your system’s software sources:
wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] http://download.webmin.com/download/repository sarge contrib"
#The add-apt-repository command will also update the package index.

#Install the latest version of Webmin by typing:

sudo apt install webmin

#All dependencies will be automatically resolved and installed. Once done, the following output will be displayed:

#Webmin install complete. You can now login to https://hostname:10000/
#as root with your root password, or as any user who can use sudo
#to run commands as root.Copy
#The Webmin service will start automatically.

#That’s it! At this point, you have successfully installed Webmin on your Ubuntu 20.04 server.
#To upgrade your Webmin installation when a new release is published, use the standard apt upgrade procedure.

#Adjust the Firewall
#By default, Webmin listens for connections on port 10000 on all network interfaces. You need to open the port in your firewall so that the Webmin interface is accessible from the Internet. Assuming you are using UFW , you can do that by running the following command:

sudo ufw allow 10000/tcp