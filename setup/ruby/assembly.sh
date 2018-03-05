apt-get -y update > /dev/null 2>&1
echo "Installing ruby dependencies..."
apt-get -y install git build-essential libssl-dev libyaml-dev libreadline-dev openssl curl git-core zlib1g-dev bison libxml2-dev libxslt1-dev libcurl4-openssl-dev libsqlite3-dev sqlite3 imagemagick libpq-dev >/dev/null 2>&1

git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv
echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
chmod +x /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

echo "Compiling Ruby. Grab some coffee, this will take a while..."

rbenv install 2.1.5
rbenv global 2.1.5

ln -f -s -T /usr/local/rbenv/shims/gem /usr/bin/gem
ln -f -s -T /usr/local/rbenv/shims/ruby /usr/bin/ruby

gem install bundler --no-rdoc --no-ri
rbenv rehash
