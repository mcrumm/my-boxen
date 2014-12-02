class people::mcrumm {
  include atom
  include bash
  include bash::completion
  include chrome
  include dropbox
  include iterm2::stable
  include mou
  include mou::themes
  include mysql
  include php::5_5
  include php::composer
  include phpstorm
  include redis
  include screen
  include sequel_pro
  include skype
  include spotify
  include sublime_text
  include transmit
  include vagrant_manager
  include vim
  include virtualbox
  include vlc

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

  package { "pstree":
    ensure => present
  }

  package { "watch":
    ensure => present
  }

  # Vim Plugins
  vim::bundle { [
    'chriskempson/base16-vim'
  ]: }

  # OSX configuations
  include osx::global::disable_key_press_and_hold
  include osx::global::expand_save_dialog
  include osx::global::expand_save_dialog
  include osx::dock::autohide
  include osx::finder::show_all_on_desktop
  include osx::finder::unhide_library
  include osx::finder::show_hidden_files
  include osx::finder::enable_quicklook_text_selection
  include osx::finder::show_all_filename_extensions
  include osx::no_network_dsstores
  include osx::global::key_repeat_delay
  include osx::global::key_repeat_rate
  class { 'osx::global::natural_mouse_scrolling':
    enabled => false
  }
  class { 'osx::dock::hot_corners':
    top_right => "Start Screen Saver",
  }
  class { 'osx::sound::interface_sound_effects':
    enable => false
  }
}
