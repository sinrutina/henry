#/bin/bash
echo "Upgrading system..."
sudo apt-get -y update >/dev/null 2>&1
sudo apt-get -y upgrade >/dev/null 2>&1

echo "Installing redis..."
sudo apt-get -y install redis-server >/dev/null 2>&1
sudo cp ~/tmp/files/redis.conf /etc/redis/redis.conf
sudo service redis-server restart

echo "Removing temp files..."
rm -rf ~/tmp
