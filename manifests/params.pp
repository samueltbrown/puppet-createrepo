# Class: createrepo::params
#
# Description
#  This class manages Createrepo parameters
#
# Parameters:
#  $repository_home - Base directory for the repository
#
# Actions:
#  Parameters for local linux repository
#
# Requires:
#
# Sample Usage:
#  This class should not be used directly
#	 
class createrepo::params {
	$base_dir 	= '/var/www/html/repository/'
	$cr_uid		= 'root'
	$cr_gid		= 'root'
}