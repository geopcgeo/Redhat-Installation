# Class: php
#
# Installs Php
#
# Usage:
# include php
#
class php::install {

       package { "php":
       name   => "${php::params::packagename}",
        ensure => present,
    }

    package { "php-common":
        name   => "${php::params::packagenamecommon}",
        ensure => present,
    }

    file { "php.ini":
        path    => "${php::params::configfile}",
        mode    => "${php::params::configfile_mode}",
        owner   => "${php::params::configfile_owner}",
        group   => "${php::params::configfile_group}",
        require => Package["php"],
                notify  => Service["apache"],
        ensure  => present,

    }
}

class php::modules {

                case $operatingsystem
                {
                        debian:
                        {       package { [ "libapache2-mod-php5","php5-cli","php5-mysql","php5-gd" ]:
                                ensure => installed,
                                                }
                        }
                        ubuntu:
                        {       package { [ "libapache2-mod-php5","php5-cli","php5-mysql","php5-gd" ]:
                                ensure => installed,
                                                }
                        }
                        default:
                        {       package { ["php-mysql","php-mbstring","php-gd"]:
                                ensure => installed,
                                                }
                        }
                }
        }




class php {
                        require php::params
                        include php::install, php::modules
                }

