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
  include redis
  include screen
  include sequel_pro
  include skype
  include spotify
  include tmux
  include transmit
  include vagrant_manager
  include vim
  include virtualbox
  include vlc

  class { 'pow':
    domains => 'pow, xip.io',
  }

  class { 'vagrant': }

  # Additional Packages
  package { [
    'git-flow',
    'android-sdk',
    'terminal-notifier',
    'reattach-to-user-namespace',
  ]: ensure => latest }

  # LastPass CLI
  package { 'lastpass-cli':
    ensure          => present,
    install_options => ['--with-pinentry', '--with-doc'],
  }

  # My Dotfiles
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

  exec { 'bootstrap.sh --force':
    path    => ['/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin', $dotfiles],
    cwd     => $dotfiles,
    require => Repository[$dotfiles],
  }

  # Mou configurations
  mou::preferences { 'Mou':
    theme => 'base16-tomorrow.dark+',
    css   => 'GitHub2',
  }

  # Vim plugins
  vim::bundle { [
    'tpope/vim-sensible',
    'chriskempson/base16-vim',
    'christoomey/vim-tmux-navigator',
    'scrooloose/nerdtree',
    'scrooloose/syntastic',
    'tpope/vim-markdown',
    'kchmck/vim-coffee-script',
    'vim-ruby/vim-ruby',
    'tpope/vim-rails',
    'tpope/vim-bundler',
    'kien/ctrlp.vim',
    'tpope/vim-surround',
    'ervandew/supertab',
    'shawncplus/phpcomplete.vim',
    'joonty/vdebug',
    'thoughtbot/vim-rspec',
    'jgdavey/tslime.vim',
    'Herzult/phpspec-vim',
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
