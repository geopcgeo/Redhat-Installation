class mysql-server {
package { [ "mysql", "mysql-server" ]:
ensure => present,
require => User["mysql"],
}

user { "mysql":
ensure => present,
comment => "MySQL user",
gid => "mysql",
shell => "/bin/false",
require => Group["mysql"],
}

group { "mysql":
ensure => present,
}
service { "mysqld":
ensure => running,
hasstatus => true,
hasrestart => true,
require => Package ["mysql-server"]
}
}



node default {
  include mysql-server
}
