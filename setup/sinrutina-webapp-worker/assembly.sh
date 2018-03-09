#/bin/bash
<%= render './setup/base/upgrade_system.sh' %>
<%= render './setup/ruby/assembly.sh' %>
<%= render './setup/node/assembly.sh' %>
<%= render './setup/base/add_swap.sh' %>

echo "Configuring crontab..."
mkdir -p /var/www/cronjobs
chown <%= user %> -R /var/www
cp /home/<%= user %>/tmp/files/deliver_events /var/www/cronjobs
chmod +x /var/www/cronjobs/deliver_events

cp /home/<%= user %>/tmp/files/cronfile /var/www/cronjobs/cronfile
crontab /var/www/cronjobs/cronfile

rm -rf /home/<%= user %>/tmp
reboot