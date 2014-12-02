class people::mcrumm {
  include chrome
  include php::5_5
  include php::composer

  $home     = "/Users/${::boxen_user}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  file { $my:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'mcrumm/dotfiles',
    require => File[$my]
  }

  service { "dev.nginx":
    ensure => "stopped"
  }

  service { "dev.dnsmasq":
    ensure => "stopped"
  }

  package { "pstree":
    ensure => present
  }

  package { "watch":
    ensure => present
  }
}
