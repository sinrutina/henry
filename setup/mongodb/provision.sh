#/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install mongodb
sudo cp ~/tmp/files/mongodb.conf /etc/mongodb.conf
sudo service mongodb restart
rm -rf ~/tmp
