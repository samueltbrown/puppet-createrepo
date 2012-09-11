# Class: createrepo
#
# Description
#  This class is designed to configure the system to use Gitolite and Gitweb
#
# Parameters:
#  $repository_home - Base directory for the repository
#
# Actions:
#  Configures a local linux repository
#
# Requires:
#  puppet-appache (if you want to have the repository hosted)
#  puppet-firewall (requirement if using puppet-apache)
#
# Sample Usage:
#  createrepo {'my.repo.org':
#		repository_home 		=> '/var/www/html/repository/',
#		repository_extension 	=> 'el/5/x85_64'
#  }
#	 
class createrepo {
	include createrepo::params
	
	$repository_dir_tree = ["/var","/var/www","/var/www/html","/var/www/html/repository/","/var/www/html/repository/el","/var/www/html/repository/el/5"]
	$repository_final_dir = "/var/www/html/repository/el/5/x86_64"
	
	File {
		owner => $createrepo::params::cr_uid,
		group => $createrepo::params::cr_gid,
		mode  => '0755',
	}
	Exec {
		path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin',
	}
	
	file {$repository_dir_tree:
		ensure => directory
	}

	# Yum Filesystem Repository Setup Including RPMs
	file { $repository_final_dir :
		source => "puppet:///modules/createrepo/rpms",
		recurse => true,
		require => File[$repository_dir_tree]
	}
	
	# Install createrepo Package
	package { 'createrepo':
		ensure => 'installed'
	}
	
	exec { 'createrepo':
		command 	=> "createrepo ${repository_final_dir}",
		require 	=> [Package['createrepo'], File [$repository_final_dir]] 
	}
}	