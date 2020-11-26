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
