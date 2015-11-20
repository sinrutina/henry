Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.ssh.forward_agent = true

  config.vm.define 'mongodb' do |mongodb|
    mongodb.vm.network "private_network", ip: "192.168.33.10"
  end

  config.vm.define 'redis' do |redis|
    redis.vm.network "private_network", ip: "192.168.33.11"
  end

  config.vm.define 'passenger' do |passenger|
    passenger.vm.network "private_network", ip: "192.168.33.12"
  end
end
