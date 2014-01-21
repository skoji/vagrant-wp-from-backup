# Vagrant-wp-from-backup

Create local Vagrant VM and install Wordpress from [backWPup](http://wordpress.org/plugins/backwpup/) backup.

## Requirements

* MacOS X (using keychain in get-backup.rb)
* Vagrant and VirtualBox, and Ruby 1.9 or above.
* tar.gz backup of working wordpress by backWPup.

## Usage

This is intended to run copy of working Wordpress site locally.

```
% git clone git@github.com:skoji/vagrant-wp-from-backup.git
% cd vagrant-wp-from-backup.git
% # edit parameters.rb
% rake
```

If you're lucky, you can see the copy of the wordpress site on http://localhost:4567 

## PROBLEMS

* Depends on keychain
* Depends on backWPup tar.gz to folder (i.e. you can not use backup to Dropbox or S3)

If you want to run on Linux, or if you want to use backup file on Dropbox or S3, you should modify get-backup.rb.






