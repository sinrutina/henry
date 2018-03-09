hostname <%= hostname %>
cp /home/<%= user %>/tmp/files/sinrutina-webapp /etc/logrotate.d/sinrutina-webapp
echo "*.*          @logs5.papertrailapp.com:41009" | tee -a /etc/rsyslog.conf

pushd /home/<%= user %>/tmp
wget https://github.com/papertrail/remote_syslog2/releases/download/v0.20-beta1/remote_syslog_linux_amd64.tar.gz
tar xzf ./remote_syslog*.tar.gz
cd remote_syslog
cp ./remote_syslog /usr/local/bin
popd

cp /home/<%= user %>/tmp/files/log_files.yml /etc/log_files.yml
cp /home/<%= user %>/tmp/files/remote_syslog.service /etc/systemd/system/remote_syslog.service

systemctl daemon-reload
systemctl start remote_syslog
systemctl enable remote_syslog

rm -rf /home/<%= user %>/tmp