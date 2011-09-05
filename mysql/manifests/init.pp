class mysql::install {

    # Load the variables used in this module. Check the params.pp file
    # Basic Package - Service - Configuration file management
    package { "mysql":
        name   => "${mysql::params::packagename}",
        ensure => present,
    }
		package { "mysql-client" :
		name   => "${mysql::params::packagename_client}",
		ensure => present,
		}

}

class mysql::config {
                case $operatingsystem
                                {
                                centos: {       file { "/etc/my.cnf":
                                                        path    => "${mysql::params::configfile}",
														ensure  => present,
                                                        source => "puppet:///modules/mysql/centos/my.cnf",
                                                        mode    => "${mysql::params::configfile_mode}",
                                                        owner   => "${mysql::params::configfile_owner}",
                                                        group   => "${mysql::params::configfile_group}",
                                                        require => Class["mysql::install"],
                                                        notify  => Class["mysql::service"],
                                                        }
                                                }
                                default:{       file { "/etc/mysql/my.cnf":
                                                        path    => "${mysql::params::configfile}",
														ensure  => present,
                                                        source => "puppet:///modules/mysql/ubuntu/my.cnf",
                                                        mode    => "${mysql::params::configfile_mode}",
                                                        owner   => "${mysql::params::configfile_owner}",
                                                        group   => "${mysql::params::configfile_group}",
                                                        require => Class["mysql::install"],
                                                        notify  => Class["mysql::service"],
                                                        }
                                                }
                }
        }

class mysql::service {

service { "mysql":
        name       => "${mysql::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${mysql::params::hasstatus}",
        pattern    => "${mysql::params::processname}",
        require         => Class["mysql::install"],
        }
}

class mysql {
        require mysql::params
        include mysql::install, mysql::config, mysql::service
}
