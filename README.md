# dotfiles

Personal dotfiles for macOS and Manjaro.

## Overview

These are configuration files, scripts, lists of packages that I have available
for two types of systems: macOS and Manjaro.

- Window Manager: Sway (Manjaro) and Yabai (macOS)
- Terminal emulator: Alacritty
- Terminal multiplexer: tmux
- Shell: Zsh
- Editor: Neovim
- Browser: Firefox

## Installation

```bash
curl --proto '=https' --tlsv1.2 -sSf https://dots.knowlerkno.ws | bash
```

### Generating Nerd Font for Dank Mono (used in Alacritty)

I still need to write out the instructions for this. For now, if you don't have
the Nerd Font, then run apply the patch and just don't commit the change:

```bash
dots patch no-nerd-font
```

## Using and maintaining

In order to make using and maintaining these dotfiles a _breeze_, I have setup a
command called `dots` which both wraps Git as well as provides some helpful
custom commands. The command works from any directory. The following sections
will cover what the custom commands do. You can run `dots` with `-h`, `--help`,
or `help` to see the usage at anytime.

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

Ideally, this would be automated when installing packages and I've seen a
`systemctl` hook to automate this which I will be exploring in the near future.
I guess a Git hook could work well for the installation part.

### Apply a patch

Predefined patches live in the `~/.patches` directory. You can use the
following command to open a fuzzy chooser for selecting which patches you want
to apply:

```bash
dots patch
```

### Open the GitHub repo in a browser window

```bash
dots web
```
