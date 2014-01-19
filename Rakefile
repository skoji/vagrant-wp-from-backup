require 'erb'
load 'parameters.rb'

task :default => :up_vm
desc 'up virtual machine'
task :up_vm => [@params[:wp_expand_dir], 'provision.sh', 'setupdb.sql', 'index.php'] do
  system('vagrant up')
end

file @params[:wp_expand_dir] => ['parameters.rb'] do
  system('ruby get-backup.rb')
end

file 'provision.sh' => ['parameters.rb', 'provision.sh.erb'] do |t|
  File.open(t.name, 'w+') do
    |file|
    file.write ERB.new(File.read('provision.sh.erb')).result
  end
end

file 'setupdb.sql' => ['parameters.rb', 'setupdb.sql.erb'] do |t|
  File.open(t.name, 'w+') do
    |file|
    file.write ERB.new(File.read('setupdb.sql.erb')).result
  end
end

file 'index.php' => ['parameters.rb', 'index.php.erb'] do |t|
  File.open(t.name, 'w+') do
    |file|
    file.write ERB.new(File.read('index.php.erb')).result
  end
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
