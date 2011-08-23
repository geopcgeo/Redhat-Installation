class php {
package { [ "php","libapache2-mod-php5","php-cli","php-mysql","php-gd" ]:
    ensure => installed,
}
}


node default
{
include php
}
