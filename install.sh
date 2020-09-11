#!/bin/bash
set -m #Set Job Control

#Get tools
sudo apt-get -y install cmake
sudo apt-get -y install build-essential #Grabs make and other important things
sudo apt-get -y install nodejs #Used in Harrogate, Node.js
sudo apt-get -y install npm #Like PIP but for node.js

#Clear the Workspace
mkdir ../tmp
mv cleanSlate.sh ../tmp/cleanSlate.sh
sudo rm -r *
mv ../tmp/cleanSlate.sh cleanSlate.sh
sudo rm -r ../tmp

#Pull from Github
( git clone https://github.com/kipr/libwallaby && echo -e "Finished Cloning Libwallaby! \n" && fg ) &
( git clone https://github.com/kipr/pcompiler && echo -e "Finished Cloning Pcompiler! \n" && fg ) &
( git clone https://github.com/kipr/libkar && echo -e "Finished Cloning Libkar! \n" && fg ) &
( git clone https://github.com/kipr/botui && echo -e "Finished Cloning Botui! \n" && fg ) &
git clone https://github.com/kipr/harrogate && echo -e "Finished Cloning Harrogate! \n" && fg

#Install Libwallaby
echo -e "\n Installing Libwallaby... \n"
cd libwallaby
sudo apt-get -y install libzbar-dev libopencv-dev libjpeg-dev python-dev doxygen swig
mkdir build
cd build
cmake ..
sudo make -j4
sudo make install libwallaby
cd ../..
echo -e "\n Finished Installing Libwallaby! \n"

#Install Pcompiler
echo -e "\n Installing Pcompiler... \n"
cd pcompiler
mkdir build
cd build
cmake ..
sudo make -j4
sudo make install pcompiler
cd ../..
echo -e "\n Finished Installing Pcompiler! \n"


#Install Libkar
echo -e "\n Installing Libkar... \n"
cd libkar
mkdir build
cd build
cmake ..
sudo make -j4
sudo make install libkar
cd ../..
echo -e "\n Finished Installing Libkar! \n"

#Install Botui
echo -e "\n Installing Botui... \n"
cd botui
mkdir build
cd build
cmake ..
sudo make -j4
sudo make install botui
cd ../..
echo -e "\n Finished Installing Botui! \n"


#Install Harrogate Dependancies
echo -e "\n Installing Harrogate Dependancies... \n"

#Node.js Setup
node -v
npm install npm@latest -g
npm -v

#Gulp Setup
npm install --global gulp-cli


#Install npm Dependancies
cd harrogate
npm install

#Get Other Requirements
sudo apt-get -y install zliblg-dev libpng-dev libbson-1.0 libboost-all-dev 

#Install libaurora
git clone https://github.com/kipr/libaurora
cd libaurora
mkdir build
cd build
cmake ..
sudo make -j4
sudo make install libaurora
cd ../..

#Install Bsonbind
git clone https://github.com/kipr/bsonbind
cd bsonbind
mkdir build
cd build
cmake ..
sudo make -j4
sudo make install bsonbind
cd ../..

#Install Daylight
git clone https://github.com/kipr/daylite
cd daylite
mkdir build
cd build
cmake ..
sudo make -j4
sudo make install daylite
cd ../..

echo -e "\n Finished Installing Harrogate Dependancies! \n"


echo -e "\n Attempting to Launch Harrogate... \n"
git clone https://github.com/kipr/harrogate
cd harrogate
gulp

echo -e "\n Finished Launching Harrogate! \n"


#Install Qt Creator
sudo apt-get -y install openjdk-7-jre qtcreator

echo "\n \n Note-1: To Start a Production Harrogate Server (KISS IDE)  you must run the following commands. \n cd harrogate \n node server.js \n \n"

echo "\n \n Note-2: To Edit .ui files, use Qt Creator (launched with 'qtcreator'), This is a graphical UI editor."


echo "--------------------------------------------- \n"
echo "Your Development Toolkit is Now Complete. \n"
echo "--------------------------------------------- \n"
