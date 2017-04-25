#!/bin/bash

GREEN_TXT='\e[0;32m'
WHITE_TXT='\e[1;37m'

printf "${GREEN_TXT}\n***Starting automatic pc installations***\n${WHITE_TXT}"


#install -f function
sudo apt-get -f install

#creating workspace directory
printf "${GREEN_TXT}Creating workspace directory\n${WHITE_TXT}"
mkdir ~/workspace
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"


#updating sources list
#echo "${green_text}Updating sources list..."
#sudo rm /etc/apt/sources.list
#sudo cp sources.list /etc/apt/sources.list
sudo apt-get -y update 
sudo apt-get -f -y upgrade
#echo "${green_text}Done."
#echo

#installing ssh server
printf "${GREEN_TXT}Installing ssh server...\n${WHITE_TXT}"
sudo apt-get purge -y openssh-server
sudo apt-get install -y openssh-server
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"



#installing terminator
printf "${GREEN_TXT}Installing terminator...\n${WHITE_TXT}"
sudo add-apt-repository -y ppa:gnome-terminator
sudo apt-get -y install terminator
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

#installing mosh
printf "${GREEN_TXT}Installing ssh mosh client...\n${WHITE_TXT}"
sudo apt-get install mosh
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

#installing geany
printf "${GREEN_TXT}Installing geany as default editor...\n${WHITE_TXT}"
sudo apt-get install geany
xdg-mime default geany.desktop $(grep MimeType /usr/share/applications/geany.desktop | sed 's/MimeType=//' | sed 's/;/ /g')
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

#installing git
printf "${GREEN_TXT}Installing git...\n${WHITE_TXT}"
sudo apt-get install git
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"


#installing ros indigo
printf "${GREEN_TXT}Installing ros indigo...\n${WHITE_TXT}"
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get -y update
sudo apt-get -f -y upgrade
sudo apt-get install -y ros-indigo-desktop-full
sudo rosdep init
rosdep update
source /opt/ros/indigo/setup.bash
sudo apt-get install -y python-rosinstall
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

#creating catkin workspace
printf "${GREEN_TXT}Creating catkin_ws...\n${WHITE_TXT}"
source /opt/ros/indigo/setup.bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
cd ~/catkin_ws/
catkin_make
source devel/setup.bash
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

#installing robotican pkg
echo "Do you want to install Robotican package? [y/n]: "
read ansA
if [ $ansA == "y" ]; then
  printf "${GREEN_TXT}Installing robotican package...\n${WHITE_TXT}"
  sudo apt-get -y update
  sudo apt-get -f -y upgrade
  cd ~/catkin_ws/src
  git clone https://github.com/robotican/robotican.git
  cd ~/catkin_ws/src/robotican/robotican/setup
  sudo chmod +x setup.sh
  ./setup.sh
  printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"
fi

#installing caja pkg
echo "Do you want to install Caja package? [y/n]: "
read ansB
if [ $ansB == "y" ]; then
  printf "${GREEN_TXT}Installing Caja package...\n${WHITE_TXT}"
  sudo apt-get -y update
  sudo apt-get -f -y upgrade
  cd ~/catkin_ws/src
  git clone https://elhayrobotican@bitbucket.org/robotsoft/robot_drive.git
  cd ~/catkin_ws/src/robot_drive/caja/setup/scripts/setup.sh 
  sudo chmod +x setup.sh
  ./setup.sh
  printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"
fi

#Fix crawling issue
printf "${GREEN_TXT}Fixing crawling issue...\n${WHITE_TXT}"
sudo umount /home/$(whoami)/.gvfs
sudo rm -r -f /home/$(whoami)/.gvfs/
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

#Fix broken packages
printf "${GREEN_TXT}Fixing broken packages...\n${WHITE_TXT}"
sudo apt-get clean
sudo apt-get install -f
sudo dpkg --configure -a
sudo apt-get update 
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

#Sync system clock
printf "${GREEN_TXT}Syncing system clock...\n${WHITE_TXT}"
sudo ntpdate ntp.ubuntu.com
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

#installing nvidia drivers
echo "Do you want to install nvidia drivers? [y/n]: "
read ansC
if [ $ansC == "y" ]; then
  printf "${GREEN_TXT}Installing nvidia drivers...\n${WHITE_TXT}"
  sudo apt-get install nvidia-current
  printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"
fi

#fixing ubuntu unity freeze
echo "Do you want to apply unity freeze fix? [y/n]: "
read ansD
if [ $ansD == "y" ]; then
  printf "${GREEN_TXT}Fixing ubuntu gui freeze...\n${WHITE_TXT}"
  sudo apt-get install --reinstall ubuntu-desktop
  sudo apt-get install unity
  printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"
fi

#installing silentcast gif recording
printf "${GREEN_TXT}Installing silentcast...\n${WHITE_TXT}"
sudo add-apt-repository ppa:sethj/silentcast  
sudo add-apt-repository ppa:mc3man/trusty-media -y
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install ffmpeg
sudo apt-get install silentcast
printf "${GREEN_TXT}Done.\n\n${WHITE_TXT}"

printf "${GREEN_TXT}***Installtion Completed***\n\n${WHITE_TXT}"
echo "Reboot is needed to apply installation changes. Reboot now? [y/n]: "
read ansE
if [ $ansE == "y" ]; then
  printf "${GREEN_TXT}\n***Rebooting...***\n\n${WHITE_TXT}"
  sleep 3
  sudo reboot
fi





