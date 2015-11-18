require 'dotenv'

Dotenv.load

assembly_line_name = ARGV[0] or raise 'you must describe an assembly line'
ssh = ARGV[1] or raise 'you must describe a server to assemble'

assembly_line = "./setup/#{assembly_line_name}"

Dir.exist?(assembly_line) or raise 'assembly line doesn\'t exist'

puts "Provisioning #{assembly_line_name} on #{ssh}..."

output = "rsync -avzP #{assembly_line}/files #{ssh}:~/tmp;"\
         "ssh #{ssh} bash -s < #{assembly_line}/provision.sh"

system(output)
