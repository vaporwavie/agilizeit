#!/bin/bash

# This script builds the whole Agilize environment.
# Be sure to chmod +x this file and don't forget
# that this will take time as fuck.
#
# Enjoy!


zenity --info --title "Agilize it!" --text "Welcome! This script will configure the whole Agilize environment in your machine.. \n \n WRN: It will take time as FUCK, so try doing some other thing while the script works." --width=300 --height=200

zenity --warning --title "Agilize it!" --text "In order to make this script work flawlessly, don't forget to chmod +x it. All the other permission related proccesses will be configured by this algorithm istelf." --width=300 --height=200

zenity --info --title "Agilize it!" --text "Time to switch to the terminal! Press OK to make this thing burn!" --width=150 --height=100

# Configurando seu ambiente

echo "Updating your machine..."
sleep 2
sudo apt update && sudo apt -y upgrade

echo "Now installing Git and Gitflow"
sleep 2
sudo apt install -y git && sudo apt install -y git-flow

echo "Installing Docker and Docker Compose"
sleep 2
echo "First... Docker Engine!"
sleep 1
sudo apt-get install -y curl \
        linux-image-extra-$(uname -r) \
            linux-image-extra-virtual
sudo apt-get install -y apt-transport-https \
                           ca-certificates
sudo curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
sudo add-apt-repository \
           "deb https://apt.dockerproject.org/repo/ \
                  ubuntu-$(lsb_release -cs) \
                         main"
sudo apt-get -y install docker-engine

echo "Now... Docker Compose!"
sleep 1
curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Checking docker-compose..."
docker-compose --version

echo "Done!"
sleep 1

echo "Installing Apache and PHP5"
sleep 2
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get install -y software-properties-common
sudo apt-get update
sudo apt-get install -y php5.6
sudo apt-get install -y php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml

echo "Checking PHP version..."
php -v

echo "Installing Java... (Pray to god for your machine)"
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt update && sudo apt install -y oracle-java8-installer
sudo apt install -y oracle-java8-set-default

echo "Installing Maven..."
sleep 2
sudo apt install -y maven

# Aplicativos que amamos! <3
sudo apt install terminator
# Still need to figure it out how to install the other ones...

zenity --info --title "Ready to ROCK!" --text "All must-have programs that we use are now installed. Have a nice coding day!"
