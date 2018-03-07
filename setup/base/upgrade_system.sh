echo "Upgrading system..."
if test $(which yum) 
then 
  yum update -y
else  
  apt-get -y update && apt-get -y upgrade
fi
