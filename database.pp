
class app::dbcreate {
exec { "db-create":
command =>"/home/ec2-user/redpuppet/scripts/mysql-db-create.sh $application_mysql_dbname",
require => Service["mysql"]
}
}
class app::dbrestore {
exec { "db-restore":
command =>"/home/ec2-user/redpuppet/scripts/mysql-db-restore.sh $application_mysql_dbname $application_mysql_dump_location_for_dbrestore",
require => Class ["app::dbcreate"],
}
}

class app {
include app::dbcreate, app::dbrestore
}

node default 
{
include app
}

