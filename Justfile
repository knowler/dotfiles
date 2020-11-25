#!/usr/bin/env just --justfile
# vim: set filetype=make :

# Install new packages
install:
	@just install-{{os()}}

install-macos:
	brew bundle install --global --cleanup --no-upgrade

install-linux:
	yay -S --needed - < $HOME/.pkglist.txt

# Dump installed packages
dump:
	@just dump-{{os()}}

dump-macos:
	brew bundle dump --global --force --no-lock

dump-linux:
	yay -Qqe > $HOME/.pkglist.txt

# Upgrade all or specified packages
upgrade *PACKAGES:
	@just upgrade-{{os()}} {{PACKAGES}}

upgrade-macos *PACKAGES:
	brew upgrade {{PACKAGES}}

upgrade-linux *PACKAGES:
	yay -Sy{{ if PACKAGES != '' {' '+PACKAGES} else {'u'} }}
