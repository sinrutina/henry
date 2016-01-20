require 'erb'
require 'dotenv'
require 'fileutils'

Dotenv.load

def render(path,context=nil)
  ERB.new(File.read(path)).result(context)
end

def compile_conf_files(assembly_line, context=nil)
  conf_files_dir = "#{assembly_line}/files"

  Dir.foreach(conf_files_dir) do |file_name|
    next if file_name == '.' or file_name == '..'
    rendered = render("#{conf_files_dir}/#{file_name}",context)
    output_file_name = file_name.gsub('.erb','')
    File.open("./compiled/files/#{output_file_name}",'w') { |f| f.write(rendered) }
  end
end

def compile_main_script(assembly_line, context=nil)
  rendered = render("#{assembly_line}/assembly.sh.erb",context)
  File.open('./compiled/assembly.sh','w') { |f| f.write(rendered) }
end

def create_compiled_folder
  FileUtils.rm_rf('./compiled')
  FileUtils.mkdir_p('./compiled/files')
end

def compile_files(assembly_line, context=nil)
  create_compiled_folder
  compile_conf_files(assembly_line,context)
  compile_main_script(assembly_line,context)
end

assembly_line_name = ARGV[0] or raise 'you must describe an assembly line'
ssh = ARGV[1] or raise 'you must describe a server to assemble'

user = ssh.split('@')[0]
server_name = ssh.split('@')[1]

assembly_line = "./setup/#{assembly_line_name}"

Dir.exist?(assembly_line) or raise 'assembly line doesn\'t exist'

compile_files(assembly_line,binding)

output = "echo \"Copying temp files...\";"\
         "rsync -avzP compiled/files #{ssh}:~/tmp > /dev/null;"\
         "ssh -A #{ssh} sudo bash -s < ./compiled/assembly.sh"

puts "Provisioning #{assembly_line_name} on #{ssh}..."
system(output)
