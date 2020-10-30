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

Note that if any of these files exist, this will fail and you will need to
either remove them or back them up using a different file name.

Run the setup script:

```bash
~/.scripts/setup.sh
```

Reload the shell:

```bash
exec $SHELL -l
```

Using the Git wrapper, set untracked files not to show in status calls for the
repo:

```bash
dots config --local status.showUntrackedFiles no
```

## Maintaining

Following those who have used the bare-repo method of dotfiles before me, I have
made an alias (two actually) as a wrapper around Git to make updating these
dotfiles a breeze. They are `dotfiles` and `dots` (I am lazy and use the
latter). You will notice a few integrations do not work like any shell
autocompletion or editor Git integration. I am sure that someone else has those
things solved, I just haven’t found that yet. Note that with using the repo
through the helper, you will need to explicitly add new files. This includes new
files that are created as a product of renaming another file.
