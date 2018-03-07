#/bin/bash
<%= render './setup/base/upgrade_system.sh' %>
<%= render './setup/ruby/assembly.sh' %>
<%= render './setup/node/assembly.sh' %>

echo "Installing passenger..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 > /dev/null 2>&1
apt-get install -y apt-transport-https ca-certificates > /dev/null 2>&1

sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'

apt-get update > /dev/null 2>&1
apt-get install -y nginx nginx-extras passenger > /dev/null 2>&1

echo "Configuring nginx..."
cp ~/tmp/files/app.conf /etc/nginx/sites-enabled
cp ~/tmp/files/nginx.conf /etc/nginx/nginx.conf

mkdir /var/www
chown <%= user %> -R /var/www

<%= render './setup/base/remove_temp_files.sh' %>
