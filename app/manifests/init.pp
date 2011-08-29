# This will do application specific settings

#This will gitclone database and drupal files folders from github.
class app::gitclone_db {        
	exec { "gitclone-db":
		command => "git clone $application_drupal_gitclone_db $application_drupal_gitclone_db_destination",
		timeout => 3600, 
       logoutput=> on_failure, 
		before => Class ["app::dbcreate"]
}
}
#This will gitclone drupal application files from github.
class app::gitclone_app {
	exec { "gitclone-application":
		command => "git clone $application_drupal_gitclone_application $application_drupal_gitclone_application_destination",
		timeout => 3600,
		require => Class ["app::gitclone_db"]
}
}
#This will create MySQL database.
class app::dbcreate {
	exec { "db-create":
		command =>"/etc/puppet/modules/app/scripts/mysql-db-create.sh $application_mysql_dbname",
		require => Service["${apache::params::servicename}"]
}
}
#This will restore MySQL database.
class app::dbrestore {
	exec { "db-restore":
		command =>"/etc/puppet/modules/app/scripts/mysql-db-restore.sh $application_mysql_dbname $application_mysql_dump_location_for_dbrestore",
		require => Class ["app::dbcreate"],
}
}
#This will change php memory limit.
class app::php_memory {
	 exec { "increase-php-memory-limit":
			command => "sed -i 's/memory_limit = .*/memory_limit = $application_php_memory_limit/' ${php::params::configfile}",
       	require => Package["${php::params::packagename"]
}
}
#This will create symlink for drupal files folder.
class app::symlink{
	exec { "symlink-for-files-folder":
		command => "ln -s $application_drupal_symlink_files_folder_source $application_drupal_symlink_files_folder_destination",
		require => Class ["app::gitclone_app"],
}
}
#This will change ownership of apache root folder to required user.
class app::change_ownership_of_a_folder{
	exec { "change-ownership-of-a-folder":
		command => "/etc/puppet/modules/app/scripts/change-folder-ownership.sh ${apache::params::username}",
		require => Class ["app::symlink"],
}
}
#This settings for enabling clean url.
class app::edit_for_cleanurl{
	exec { "edit-apache2-conf-file":
		command => "sed -i 's/AllowOverride None/AllowOverride All/' ${apache::params::virtualhostconf}",
       require => Package["${apache::params::servicename}"]
}
}
#This will edit apache document root.
class app::edit_for_documentroot{
	exec { "edit-documentRoot-folder-path":
       command => "/etc/puppet/modules/app/scripts/edit-documentRoot-folder-path.sh ${apache::params::documentroot} $application_apache_current_documentroot ${apache::params::virtualhostconf}",
      require => Package["${apache::params::servicename}"]
}
}
#This will give write permission to files folder.
class app::write_permissions_to_files_folder {
	exec { "write-permissions-to-files-folder":
		command => "/etc/puppet/modules/app/scripts/drupal-files-folder-permission.sh",
		require => Class ["app::change_ownership_of_a_folder"]
		
}
}

class app {
	require apache::params
	require php::params
	include app::gitclone_db, app::gitclone_app, app::dbcreate, app::dbrestore, app::php_memory, app::symlink, app::edit_for_cleanurl, app::edit_for_documentroot, app::write_permissions_to_files_folder, app::change_ownership_of_a_folder
}

