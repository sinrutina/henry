#/bin/bash
sudo apt-get -y update >/dev/null 2>&1
sudo apt-get -y upgrade >/dev/null 2>&1

sudo apt-get -y install mongodb >/dev/null 2>&1
sudo cp ~/tmp/files/mongodb.conf /etc/mongodb.conf
sudo service mongodb restart

rm -rf ~/tmp
