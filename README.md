# dotfiles

all the cool kids do this

## Overview

These are configuration files, scripts, lists of packages that I have available
for two types of systems: macOS and Manjaro. Manjaro is my daily driver so those
are more fleshed out and existent in this repository. This is an overview of the
core software that I use:

- Window Manager: Sway (Manjaro) and Yabai (macOS)
- Terminal emulator: Alacritty
- Terminal multiplexer: tmux
- Shell: Zsh
- Editor: Neovim
- Browser: Firefox

## Installation

Note that this presumes that you’ve already got `git` setup which may very well
not be the case if you are on macOS. If that is you, run `xcode-select
--install` first.

Clone the bare repository:

```bash
git clone https://github.com/knowler/dotfiles.git $HOME/.dotfiles --bare
```

Checkout the files in your `$HOME` directory:

```bash
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
```

Run the set up script:

```bash
./.scripts/setup.sh
```

Reload the shell:

```bash
exec $SHELL -l
```
