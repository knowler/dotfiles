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

### Generating Nerd Font for Dank Mono (used in Alacritty)

I still need to write out the instructions for this. For now, if you don’t have
the Nerd Font, then run apply the patch and just don’t commit the change:

```bash
dots apply ~/.patches/alacritty-no-nerd-font.patch
```

## Maintaining

Some notes on maintaining.

### Using the `dots` Git wrapper alias

Following those who have used the bare-repo method of dotfiles before me, I have
made an alias `dots` as a wrapper around Git to make updating these dotfiles a
breeze. You will notice a few integrations do not work like any shell
autocompletion or editor Git integration. I am sure that someone else has those
things solved, I just haven’t found that yet. Note that with using the repo
through the helper, you will need to explicitly add new files. This includes new
files that are created as a product of renaming another file.

### Quickly edit a tracked dotfile

I have a script `dot` which feeds all tracked dotfiles into `fzf` for selection.

### Installing new packages

To install new packages for either system run:

```bash
just install
```

### Upgrading packages

To upgrade _all_ packages for either system run:

```bash
just upgrade
```

To upgrade _specified_ packages for either system run:

```bash
just upgrade [packages]
```

### Dumping package lists

To dump recent packages you might have installed to package list use:

```bash
just dump
```

Ideally, this would be automated when installing packages and I’ve seen a
`systemctl` hook to automate this which I will be exploring in the near future.
I guess a Git hook could work well for the installation part.
