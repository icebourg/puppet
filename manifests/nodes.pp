node default {
  ssh_authorized_key { "ssh_key_root_mba":
    ensure	=> present,
    key		=> "AAAAB3NzaC1yc2EAAAADAQABAAACAQC+0AsW14m7vnmywQ6/RXqedwHwmBMzUGoS4YeXSYNDcWak1DVuN7thXbGy5W8pYwHkDAXeMnJ6zdbWAJv4WkE2ue7lICmGmQCNHSWaq7y2PG+PdgZ9Ig6LIabnETRPMdgUm0Fe2DEWocLxXfhuYP8KXinwjaUB9oaHMFR/7nOcEXriYXXt0yz+Q1Yyoa7hXCkPniQ0j6k0xrBuvE/MguTdWxgRfx0BXwjNQd0cMyMXhOww0SeTQ4N9S1L7h0P6OZBBET/EY910Yh27F5aGJaIg2cYweVNJ1yEWAXjp/TyOQZfsXL7+jkdlujlmz6nROTlldbHGRl4S7ZlCn7Hz77j0xsoKEMcyS/S36vAwwNV+o/JicT4CtQB9yy+ixL2rIkbkji2AgATKrWvsJlF94ASVbFSvWll/jO4mWnMZopjllBVtAk/hBi5tvP5zsf2G0CaEy66Z3YEm1ywVI+Aq/Dv6Cgb5T5F2WZiZNZ7BVz5kq16vbiON8NmOIWG0byjE6A6/2sQ+tQwu7w3FXHAvpw+KFz2vaPZpByLcF2eJo2lM0I4OIVgWpBVxFgzu1UJTYkrCN/SRIcvVphq9WMhp5OyGJ2RzkSsCBpIToLdgF3pvTyOlEoqobIvt7ztp6TJrgyi0gsvIgYvAIYdNYbiPdXMFbTzj5EEumP0E3wlk4rzGYw==",
    type	=> "rsa",
    user	=> root,
  }
  
  # crap I always want installed but never seems to be...
  package { ['vim', 'git-core']:
    ensure => "present"
  }
}

node /srv.*/ inherits default {
  
  include php::fpm
  
  php::fpm::pool { 'www':
    listen    => '/var/run/fpm_www.sock',
    pm_max_requests => 500,
  }
  
  file { "/var/www":
    ensure  => "directory"
  }
  
  include nginx
  
  nginx::site { "ajbourg.com":
    domain  => "ajbourg.com",
    aliases => ["www.ajbourg.com", "${hostname}.ajbourg.com", "dev.ajbourg.com"],
    root    => "/var/www/ajbourg.com/html",
    require => File["/var/www"]
  }
  
  deployinator::git::deploy_repo { "ajbourg.com":
    path    => "/var/www/ajbourg.com",
    repo    => "git@github.com:icebourg/ajbourg.com.git"
  }
}

node /minecraft\-.*/ inherits default {
  include minecraft-server
  
  minecraft-server::manage { "survival":
    user       => "survival",
    group      => "survival",
    path       => "/home/minecraft-survival",
    snapshot   => "13w09c",
    properties => {
      "SVport" => { "key" => "server-port", "value" => "25566" },
      "SVlevel-name" => { "key" => "level-name", "value" => "SurvivalWorld" },
      "SVmax-players" => { "key" => "max-players", "value" => "5" },
      "SVmotd" => { "key" => "motd", "value" => "The Survival of the Firstest" },
    }
  }
  
  minecraft-server::manage { "controlled-chaos":
    path        => "/home/minecraft-cc",
    properties  => {
      "CCport" => { "key" => "server-port", "value" => "25565" },
      "CClevel-name" => { "key" => "level-name", "value" => "ControlledChaos" },
      "CCmax-players" => { "key" => "max-players", "value" => "10" },
      "CCmotd" => { "key" => "motd", "value" => "CoNTRoLLeD chAOs MiNeCRaFT sErvEr" },
    }
  }
}