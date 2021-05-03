# Defines environment variables.
ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
 
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# --httptoolkit--
# This section will be reset each time a HTTP Toolkit terminal is opened
if [ -n "$HTTP_TOOLKIT_ACTIVE" ]; then
    # When HTTP Toolkit is active, we inject various overrides into PATH
    export PATH="/Applications/HTTP Toolkit.app/Contents/Resources/app/httptoolkit-server/overrides/path:$PATH"

    if command -v winpty >/dev/null 2>&1; then
        # Work around for winpty's hijacking of certain commands
        alias php=php
        alias node=node
    fi
fi
# --httptoolkit-end--

if [ -e /Users/knowler/.nix-profile/etc/profile.d/nix.sh ]
then . /Users/knowler/.nix-profile/etc/profile.d/nix.sh; fi
