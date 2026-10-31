#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Vars for Guix Home Hack
export HOME_ENVIRONMENT=$HOME/.guix-home
export XDG_DATA_DIRS=$HOME_ENVIRONMENT/profile/share:/usr/local/share:/usr/share:$XDG_DATA_DIRS
# export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-/run/user/$UID}
export XDG_LOG_HOME=$HOME/.local/var/log
export XDG_STATE_HOME=$HOME/.local/state
export MANPATH=/usr/share/man
export INFOPATH=/usr/share/info
export XCURSOR_PATH=/usr/share/icons
