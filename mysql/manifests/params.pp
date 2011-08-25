# Class: mysql::params
#
# Sets internal variables and defaults for mysql module
# This class is automatically loaded in all the classes that use the values set here 
#
class mysql::params  {

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)
# (The default used is in the line with '')


    $logfile = $operatingsystem ? {
        default => "/var/log/mysqld.log",
    }


## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

    $packagename = $operatingsystem ? {
        default => "mysql-server",
    }

    $packagename_client = $operatingsystem ? {
        redhat  => "mysql",
        centos  => "mysql",
        default => "mysql-client",
    }

    $servicename = $operatingsystem ? {
        redhat  => "mysqld",
        centos  => "mysqld",
        default => "mysql",
    }

    $processname = $operatingsystem ? {
        default => "mysqld",
    }

    $hasstatus = $operatingsystem ? {
        debian  => false,
        ubuntu  => false,
        default => true,
    }

    $configfile = $operatingsystem ? {
        debian  => "/etc/mysql/my.cnf",
        ubuntu  => "/etc/mysql/my.cnf",
        default => "/etc/my.cnf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $configdir = $operatingsystem ? {
        default => "/etc/mysql/conf.d",
    }

    $initconfigfile = $operatingsystem ? {
        debian  => "/etc/default/mysql",
        ubuntu  => "/etc/default/mysql",
        default => "/etc/sysconfig/mysqld",
    }
    
    # Used by monitor class
    $pidfile = $operatingsystem ? {
        default  => "/var/run/mysqld/mysqld.pid",
    }

    # Used by backup class
    $datadir = $operatingsystem ? {
        default => "/var/lib/mysql",
    }

    # Used by backup class - Provide the file name, if there's no dedicated dir
    $logdir = $operatingsystem ? {
        default => "/var/log/mysql",
    }

    # Used by monitor and firewall class
    # If you need to define additional ports, call them $protocol1/$port1 and add the relevant
    # parts in firewall.pp and monitor.pp
    $protocol = "tcp"
    $port = "3306"
    
}

