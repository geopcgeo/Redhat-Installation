# Class: mysql
#
# Manages mysql.
# Include it to install and run mysql
# It defines package, service, main configuration file.
#
# Usage:
# include mysql
#
class mysql::install {

    # Load the variables used in this module. Check the params.pp file 
    require mysql::params

    # Basic Package - Service - Configuration file management
    package { "mysql":
        name   => "${mysql::params::packagename}",
        ensure => present,
    }

	
    service { "mysql":
        name       => "${mysql::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${mysql::params::hasstatus}",
        pattern    => "${mysql::params::processname}",
        require    => Package["mysql"],
        subscribe  => File["mysql.conf"],
    }

}

class mysql::config {
	file { "mysql.conf":
		ensure  => present,
        require => Package["mysql"],
		case $operatingsystem
			{	
				centos: {	path    => "${mysql::params::configfile}",
							source => "puppet:///modules/mysql/centos/my.cnf",
						}
				default:{	path    => "${mysql::params::configfile}",
							source => "puppet:///modules/mysql/ubuntu/my.cnf",
						}
			}
		mode    => "${mysql::params::configfile_mode}",
        owner   => "${mysql::params::configfile_owner}",
        group   => "${mysql::params::configfile_group}",
		notify  => Service["mysql"],

	}		
class mysql {
	include mysql::install, mysql::config
}

