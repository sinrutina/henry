require 'erb'
require 'fileutils'
require 'optparse'

class Henry

  def initialize
    @options = parse(ARGV)
  end

  def render(path,context=nil)
    ERB.new(File.read(path)).result(context)
  end

  def compile_conf_files(assembly_line, context=nil)
    conf_files_dir = "#{assembly_line}/files"

    if Dir.exist?(conf_files_dir)
      FileUtils.mkdir_p('./compiled/files')
      Dir.foreach(conf_files_dir) do |file_name|
        next if file_name == '.' or file_name == '..'
        rendered = render("#{conf_files_dir}/#{file_name}",context)
        output_file_name = file_name.gsub('.erb','')
        File.open("./compiled/files/#{output_file_name}",'w') { |f| f.write(rendered) }
      end
    end
  end

  def compile_main_script(assembly_line, context=nil)
    rendered = render("#{assembly_line}/assembly.sh.erb",context)
    File.open('./compiled/assembly.sh','w') { |f| f.write(rendered) }
  end

  def create_compiled_folder
    FileUtils.rm_rf('./compiled')
    FileUtils.mkdir_p('./compiled')
  end

  def compile_files(assembly_line, context=nil)
    create_compiled_folder
    compile_conf_files(assembly_line,context)
    compile_main_script(assembly_line,context)
  end

  def parse(args)
    options = {}

    OptionParser.new do |opts|
      opts.banner = "Usage: henry [options]"

      opts.on("-a", "--assembly ASSEMBLY", "Line to assemble") do |a|
        options[:assembly] = a
      end

      opts.on("-h", "--hostname USER@HOSTNAME", "ssh format of user and hostname") do |s|
        options[:ssh] = s
      end
    end.parse!(args)

    options
  end

  def execute
    assembly_line_name = @options[:assembly] or raise 'you must describe an assembly line'
    ssh = @options[:ssh] or raise 'you must describe a server to assemble'

    user = ssh.split('@')[0]
    server_name = ssh.split('@')[1]

    assembly_line = "./setup/#{assembly_line_name}"

    Dir.exist?(assembly_line) or raise 'assembly line doesn\'t exist'

    compile_files(assembly_line,binding)

    if Dir.exist?('./compiled/files')
      puts 'Copying temp files...'
      system("scp compiled/files/* #{ssh}:~/tmp > /dev/null;")
    end

    puts "Provisioning #{assembly_line_name} on #{ssh}..."
    system("ssh -A #{ssh} sudo bash -s < ./compiled/assembly.sh")
  end
end
