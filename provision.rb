require 'erb'
require 'dotenv'
require 'fileutils'

Dotenv.load

def render(path,context=nil)
  ERB.new(File.read(path)).result(context)
end

assembly_line_name = ARGV[0] or raise 'you must describe an assembly line'
ssh = ARGV[1] or raise 'you must describe a server to assemble'

assembly_line = "./setup/#{assembly_line_name}"

Dir.exist?(assembly_line) or raise 'assembly line doesn\'t exist'

rendered = render("#{assembly_line}/provision.sh.erb",binding)

FileUtils.mkdir_p('./compiled')
File.open('./compiled/provision.sh','w') { |f| f.write(rendered) }

output = "echo \"Copying temp files...\";"\
         "rsync -avzP #{assembly_line}/files #{ssh}:~/tmp > /dev/null;"\
         "ssh #{ssh} bash -s < ./compiled/provision.sh"

puts "Provisioning #{assembly_line_name} on #{ssh}..."
system(output)
