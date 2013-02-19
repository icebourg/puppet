node default {

	ssh_authorized_key { "ssh_key_root_mba":
		ensure	=> present,
		key	=> "AAAAB3NzaC1yc2EAAAADAQABAAACAQC+0AsW14m7vnmywQ6/RXqedwHwmBMzUGoS4YeXSYNDcWak1DVuN7thXbGy5W8pYwHkDAXeMnJ6zdbWAJv4WkE2ue7lICmGmQCNHSWaq7y2PG+PdgZ9Ig6LIabnETRPMdgUm0Fe2DEWocLxXfhuYP8KXinwjaUB9oaHMFR/7nOcEXriYXXt0yz+Q1Yyoa7hXCkPniQ0j6k0xrBuvE/MguTdWxgRfx0BXwjNQd0cMyMXhOww0SeTQ4N9S1L7h0P6OZBBET/EY910Yh27F5aGJaIg2cYweVNJ1yEWAXjp/TyOQZfsXL7+jkdlujlmz6nROTlldbHGRl4S7ZlCn7Hz77j0xsoKEMcyS/S36vAwwNV+o/JicT4CtQB9yy+ixL2rIkbkji2AgATKrWvsJlF94ASVbFSvWll/jO4mWnMZopjllBVtAk/hBi5tvP5zsf2G0CaEy66Z3YEm1ywVI+Aq/Dv6Cgb5T5F2WZiZNZ7BVz5kq16vbiON8NmOIWG0byjE6A6/2sQ+tQwu7w3FXHAvpw+KFz2vaPZpByLcF2eJo2lM0I4OIVgWpBVxFgzu1UJTYkrCN/SRIcvVphq9WMhp5OyGJ2RzkSsCBpIToLdgF3pvTyOlEoqobIvt7ztp6TJrgyi0gsvIgYvAIYdNYbiPdXMFbTzj5EEumP0E3wlk4rzGYw==",
		type	=> "rsa",
		user	=> root,
	}
	
	# dependencies for building gems
	Package { ['ruby1.9.1-dev', 'rubygems', 'ruby1.9.1-full']:
	    ensure => "present"
	}
	
	# bootstrap being able to run puppet librarian for our Puppet file
	Package { 'librarian-puppet':
        ensure      => 'installed',
        provider    => 'gem',
        require     => [Package['ruby1.9.1-dev'], Package['rubygems'], Package['ruby1.9.1-full']]
  }
}
