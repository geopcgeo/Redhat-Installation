class mysql::install {

    # Load the variables used in this module. Check the params.pp file
    # Basic Package - Service - Configuration file management
    package { "mysql":
        name   => "${mysql::params::packagename}",
        ensure => present,
    }


}

class mysql::config {
                case $operatingsystem
                                {
                                centos: {       file { "mysql.conf":
                                                        path    => "${mysql::params::configfile}",
                                                        source => "puppet:///modules/mysql/centos/my.cnf",
                                                        mode    => "${mysql::params::configfile_mode}",
                                                        owner   => "${mysql::params::configfile_owner}",
                                                        group   => "${mysql::params::configfile_group}",
                                                        ensure  => present,
                                                        require => Class["mysql::install"],
                                                        notify  => Class["mysql::service"],
                                                        }
                                                }
                                default:{       file { "mysql.conf":
                                                        path    => "${mysql::params::configfile}",
                                                        source => "puppet:///modules/mysql/ubuntu/my.cnf",
                                                        mode    => "${mysql::params::configfile_mode}",
                                                        owner   => "${mysql::params::configfile_owner}",
                                                        group   => "${mysql::params::configfile_group}",
                                                        ensure  => present,
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
