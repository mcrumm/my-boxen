class people::mcrumm {
  include chrome

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
    ensure => present,
  }

  package { "watch":
    ensure => present,
  }

  exec { "tap-homebrew-dupes":
    command => "brew tap homebrew/dupes",
    creates => "${homebrew::config::tapsdir}/homebrew-dupes",
  }
  
  exec { "tap-homebrew-versions":
    command => "brew tap homebrew/versions",
    creates => "${homebrew::config::tapsdir}/homebrew-versions",
  }

  exec { "homebrew/homebrew-php":
    command => "brew tap homebrew/homebrew-php",
    creates => "${homebrew::config::tapsdir}/homebrew-php",
    require => [ Exec["tap-homebrew-dupes"], Exec["tap-homebrew-versions"] ],
  }

  package { "php55":
    ensure => present,
    require => [
      Exec["homebrew/homebrew-php"],
      Package["pstree"],
      Package["watch"],
    ],
  }
}
