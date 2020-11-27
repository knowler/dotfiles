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

```bash
curl --proto https --tlsv1.2 -sSf https://dots.knowlerkno.ws | bash
```

### Generating Nerd Font for Dank Mono (used in Alacritty)

I still need to write out the instructions for this. For now, if you don’t have
the Nerd Font, then run apply the patch and just don’t commit the change:

```bash
dots patch no-nerd-font
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

Optionally enter the name of the file. If specific enough, the file will just
open in the editor.

```bash
dots open <file?>
```

### Installing new packages

To install new packages for either system run:

```bash
dots install
```

### Upgrading packages

To upgrade _all_ packages for either system run:

```bash
dots upgrade
```

To upgrade _specified_ packages for either system run:

```bash
dots upgrade [packages]
```

### Dumping package lists

To dump recent packages you might have installed to package list use:

```bash
dots dump
```

Ideally, this would be automated when installing packages and I’ve seen a
`systemctl` hook to automate this which I will be exploring in the near future.
I guess a Git hook could work well for the installation part.
