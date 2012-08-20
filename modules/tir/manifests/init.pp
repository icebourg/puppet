class tir {

	# lua tir framework dependencies

	package { ["curl", "luarocks", "libzmq-dev", "libsqlite3-dev"]:
		ensure	=> present,
	}

}
