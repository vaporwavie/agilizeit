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

echo "Configuring SSH (TBD)"
sleep 2
# TODO

echo "Installing Docker and Docker Compose (TBD)"
sleep 2
# TODO

echo "Installing Apache and PHP5 (TBD)"
sleep 2
# TODO

echo "Installing Java... (Pray to god for your machine) -> TBD"
# TODO

echo "Installing Maven... (TBD)"
sleep 2
# TODO

echo "Nice! The must-have part is finished. Now we're going to clone the most used agilize repositories to your www folder! (/var/www/html/REPOSITORIES)"
sleep 2
echo "Relax, this script also configures the whole clone config stuff."

# Aplicativos que amamos! <3
# TODO add Terminator, PHPStorm, Eclipse, VSCode, Chrome, Slack, Google Remote


zenity --info --title "All configured!" --text "Enjoy the whole thing. :)"
