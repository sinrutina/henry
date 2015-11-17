require 'dotenv'

Dotenv.load

username = ENV['USERNAME']
hosto = ENV['HOST']

ssh = "#{username}@#{host}"

system("rsync -avzP ./setup/files #{ssh}:~/tmp")
system("ssh #{ssh} bash -s < ./setup/provision.sh")
