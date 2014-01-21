require 'erb'
load 'parameters.rb'

def render_erb(dest, src = nil)
  src ||= "#{dest}.erb"
  File.open(dest, 'w+') do
    |file|
    file.write ERB.new(File.read(src)).result
  end
end

task :default => :up_vm
desc 'up virtual machine'
task :up_vm => [@params[:wp_expand_dir], 'provision.sh', 'setupdb.sql', 'index.php'] do
  system('vagrant up')
end

file @params[:wp_expand_dir] => ['parameters.rb'] do
  system('ruby get-backup.rb')
end

file 'provision.sh' => ['parameters.rb', 'provision.sh.erb'] do |t|
  render_erb(t.name)    
end

file 'setupdb.sql' => ['parameters.rb', 'setupdb.sql.erb'] do |t|
  render_erb(t.name)    
end

file 'index.php' => ['parameters.rb', 'index.php.erb'] do |t|
  render_erb(t.name)    
end

desc 'clean and get new backup'
task :clean_get do
  system('ruby get-backup.rb')
end

desc 'clean all'
task :clean_all do
  system("rm -rf @params[:wp_expand_dir]")
  system('vagrant destroy')
end
