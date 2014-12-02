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
}
