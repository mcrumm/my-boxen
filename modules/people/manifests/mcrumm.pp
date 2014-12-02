class people::mcrumm {
  include chrome
  include iterm2::stable
  include mysql
  include php::5_5
  include php::composer
  include phpstorm
  include pow
  include skype
  include sublime_text

  class { 'pow':
    domains => 'pow, xip.io',
  }

  class { 'vagrant': }

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
