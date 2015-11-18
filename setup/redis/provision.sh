#/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install redis-server
sudo cp ~/tmp/files/redis.conf /etc/redis/redis.conf
sudo service redis-server restart

rm -rf ~/tmp
