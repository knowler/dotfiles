#!/usr/bin/env just --justfile
# vim: set filetype=make :

# Install new packages
install:
	@just _install-{{os()}}

_install-macos:
	brew bundle install --global --cleanup --no-upgrade

_install-linux:
	yay -S --needed - < $HOME/.pkglist.txt

# Dump installed packages
dump:
	@just _dump-{{os()}}

_dump-macos:
	brew bundle dump --global --force --no-lock

_dump-linux:
	yay -Qqe > $HOME/.pkglist.txt

# Upgrade all or specified packages
upgrade *PACKAGES:
	@just _upgrade-{{os()}} {{PACKAGES}}

_upgrade-macos *PACKAGES:
	brew upgrade {{PACKAGES}}

_upgrade-linux *PACKAGES:
	yay -Sy{{ if PACKAGES != '' {' '+PACKAGES} else {'u'} }}

# Setup the specified programs
setup *PROGRAMS:
	programs=({{PROGRAMS}}); for program in ${programs[*]}; do just _setup-$program; done

_setup-zsh:
	@echo "Setting up zsh..."
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

_setup-tmux:
	@echo "Setting up tmux..."
	git clone https://github.com/tmux-plugins/tpm ${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins/tpm

_setup-neovim:
	@echo "Setting up Neovim..."
	curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | sh
	nvim +PlugInstall +quitall

_setup-node:
	@echo "Setting up Node..."
	volta install node@latest
	volta fetch node@lts
	volta install yarn
