####
#
# Setup a mysql server.
#
####

class mysql::server {

	# every MySQL server will come with a daily backup built in
	# need a place to store that backup
	file { "/sqldumps":
		ensure	=> directory,
		owner	=> root,
		group	=> root,
		mode	=> 700,
	}

	file { "/sqldumps/dump.sh":
		ensure	=> present,
		source	=> "puppet:///modules/mysql/dump.sh",
		owner	=> root,
		group	=> root,
		mode	=> 755,
		require	=> File["/sqldumps"],
	}

	cron { mysql-dump:
		command	=> "/sqldumps/dump.sh",
		user	=> root,
		hour	=> 02,
		minute	=> 34,
	}
}
