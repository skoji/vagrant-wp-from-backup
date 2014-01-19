require 'net/ftp'
load 'parameters.rb'

username = %x(security find-internet-password -s #{@params[:ftphost]} | grep "acct" | cut -d '"' -f 4).strip
password = %x(security 2>&1 >/dev/null find-internet-password -gs #{@params[:ftphost]} | cut -d '"' -f 2).strip

Dir.chdir(File.dirname(__FILE__)) do
  Net::FTP.open(@params[:ftphost]) do |ftp|
    ftp.login(username, password)
    ftp.chdir(@params[:ftpdir])
    files = ftp.list('-t1', '*.tar.gz')
    if files.size > 0 && files[0].index("#{@params[:backup_file_starts]}") == 0
      puts "Downloading latest backup #{files[0]} as backup_latest.tar.gz .."
      ftp.get(files[0], 'backup_latest.tar.gz')
    else
      raise 'can not find backup file'
    end
  end
  if Dir.exists?(@params[:wp_expand_dir])
    %x(rm -rf #{@params[:wp_expand_dir]})
  end
  Dir.mkdir(@params[:wp_expand_dir])
  Dir.chdir(@params[:wp_expand_dir]) do
    %x(tar xfz ../backup_latest.tar.gz; chmod +w wp-config.php)
    File.rename("wp-config.php", "wp-config.php.org")
    File.open("wp-config.php", "w+") do |out|
      File.open("wp-config.php.org") do |orig|
        while line = orig.gets
          out.puts line.sub(/^define\('DB_NAME'.*$/, "define('DB_NAME', '#{@params[:db_name]}');").sub(/^define\('DB_USER',.*/,"define('DB_USER', 'root');").sub(/define\('DB_PASSWORD',.*/,"define('DB_PASSWORD', '#{@params[:db_password]}');").sub(/^define\('DB_HOST'.*$/, "define('DB_HOST', 'localhost');")
        end
      end
    end

  end
end

