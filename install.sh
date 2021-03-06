#!/bin/bash

# Script to provide a one line install for a function launcher for the Raspberry Pi.
# 
# Motivating use case:
# - To be able to provide consise and robust instructions for installing a basic
#   Raspberry Pi setup.
#   
# Usage:
# 
# curl -L https://github.com/coders4liberty/function-launcher/raw/master/install.sh | sh
# wget --no-delete-certificate https://github.com/coders4liberty/function-launcher/raw/master/install.sh -O - | sh

LAUNCHER_DIR="/opt/kano/function-launcher"

delete()
{  
	read key

	case $key in
	[yY][eE][sS]|[yY]|"")
		sudo rm -rf $1
		echo -e "\nDelete $1 complete!\n" 
	;;
	*)
	exit
	;;
	esac
}

#Update source-list of dependencies
echo -e "====================================\n"
echo -e "\n Updating source lists to download dependencies ... \n Please check your internet connection! \n"
echo -e "====================================\n"
sleep 2
sudo apt-get update 





if test -d $LAUNCHER_DIR;
then
  	echo  -e "\n[Function Launcher installer] It looks like you've already got the Function Launcher installed."
  	echo  -e "\n[Function Launcher installer] You'll need to remove $LAUNCHER_DIR to install."
  	echo  -e "\nWould you like to remove [Function Launcher installer] directory[Y/n]?"
	delete $LAUNCHER_DIR ;
fi

# Make NES directory
sudo mkdir NES

# Download Function from NES World into NES folder



echo -e "[Function Launcher installer] Installing NES emulator FCEUX ..."
sudo apt-get -y install fceux

echo  -e "\nInstalling git ...\n"
sudo apt-get -y install git

echo -e "\n[Function Launcher installer] Installing desktop icon."
sudo mkdir -p $LAUNCHER_DIR
sudo git clone git://github.com/coders4liberty/function-launcher.git $LAUNCHER_DIR
sudo cp $LAUNCHER_DIR/function.desktop /usr/share/applications

#sudo wget http://www.nesworld.com/homebrew/function.zip
#sudo cp function.zip $LAUNCHER_DIR/fuction.zip

if test -e ~/Desktop/function.desktop; 
then
	echo -e "\n~/Desktop/function.desktop file has existes!\nDo you want to remove it[y/n]?"
	delete ~/Desktop/function.desktop;	
fi
	
sudo ln -s $LAUNCHER_DIR/function.desktop ~/Desktop/function.desktop
sudo chmod +x ~/Desktop/function.desktop
sudo chown $(whoami) ~/Desktop/function.desktop
sleep  2
echo -e "\nComplete!\n"
