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

  exec { "tap-homebrew-dupes":
    command => "brew tap homebrew/dupes",
    creates => "${homebrew::config::tapsdir}/homebrew-dupes",
  }

  exec { "josegonzalez/homebrew-php":
    command => "brew tap josegonzalez/homebrew-php",
    creates => "${homebrew::config::tapsdir}/josegonzalez-php",
    require => Exec["tap-homebrew-dupes"],
  }

  package { "php55":
    ensure => present,
    require => [
      Exec["josegonzalez/homebrew-php"],
      Package["pstree"],
      Package["watch"],
    ],
  }
}
