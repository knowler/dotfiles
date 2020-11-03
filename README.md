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

Some notes on maintaining.

### Using the `dots` Git wrapper alias

Following those who have used the bare-repo method of dotfiles before me, I have
made an alias (two actually) as a wrapper around Git to make updating these
dotfiles a breeze. They are `dotfiles` and `dots` (I am lazy and use the
latter). You will notice a few integrations do not work like any shell
autocompletion or editor Git integration. I am sure that someone else has those
things solved, I just haven’t found that yet. Note that with using the repo
through the helper, you will need to explicitly add new files. This includes new
files that are created as a product of renaming another file.

### Installing packages and keeping package lists up-to-date

Note that running the setup script again will install new packages for you. If
you want packages that you’ve added to persist, make sure to generate a new
package list _before_ you pull so that you can merge the changes accordingly.

#### macOS

On macOS, use the following command to install new packages from `~/.Brewfile`:

```bash
brew bundle install --global --cleanup
```

If you’ve installed packages, run the following command to “update” the file:

```bash
brew bundle dump --global --force
```

The `--force` flag allows the command to write over the file (kind of annoying,
if you ask me).

#### Manjaro

On Manjaro, use the following command to install new packages from
`~/.pkglist.txt`:

```bash
yay -S --needed - < $HOME/.pkglist.txt
```

If you’ve installed packages, generate a new list of packages run the following
command:

```bash
yay -Qqe > $HOME/.pkglist.txt

# or from $HOME

make -B .pkglist.txt
```

I’ve seen a `systemctl` hook to automate this which I will be exploring in the
near future. I guess a Git hook could work well for the installation part.
