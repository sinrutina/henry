#/bin/bash
<%= render './setup/base/upgrade_system.sh' %>
<%= render './setup/ruby/assembly.sh' %>
<%= render './setup/node/assembly.sh' %>
<%= render './setup/base/add_swap.sh' %>

echo "Configuring systemd web service..."
cp /home/<%= user %>/tmp/files/sinrutina-web.service /etc/systemd/system
systemctl daemon-reload
systemctl enable sinrutina-web
mkdir -p /var/www
chown <%= user %> -R /var/www

rm -rf /home/<%= user %>/tmp
reboot