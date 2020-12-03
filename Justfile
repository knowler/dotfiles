#!/usr/bin/env just --justfile
# vim: set filetype=make :

# Upgrade all or specified packages
upgrade *PACKAGES:
	@just _upgrade-{{os()}} {{PACKAGES}}

_upgrade-macos *PACKAGES:
	brew upgrade {{PACKAGES}}

_upgrade-linux *PACKAGES:
	yay -Sy{{ if PACKAGES != '' {' '+PACKAGES} else {'u'} }}

# Setup the specified programs
setup *PROGRAMS='all':
	@programs=({{PROGRAMS}}); for program in ${programs[@]}; do just _setup-$program; done

_setup-all:
	@echo "Todo: setup all programs"

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
