#!/usr/bin/env just --justfile
# vim: set filetype=make :

install:
	@just install-{{os()}}

install-macos:
	brew bundle install --global --cleanup --no-upgrade

install-linux:
	yay -S --needed - < "$(HOME)/.pkglist.txt"

dump:
	@just dump-{{os()}}

dump-macos:
	brew bundle dump --global --force --no-lock

dump-linux:
	yay -Qqe > "$(HOME)/.pkglist.txt"

upgrade:
	@just upgrade-{{os()}}

upgrade-macos:
	brew upgrade

upgrade-linux:
	yay -Syu
