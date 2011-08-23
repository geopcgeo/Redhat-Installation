class apache-server {
package { [ "httpd" ]:
ensure => present,
}
service { "httpd":
ensure => running,
hasstatus => true,
hasrestart => true,
enable => true,
require => Package ["httpd"],
}
}


node default
{
include apache-server
}

