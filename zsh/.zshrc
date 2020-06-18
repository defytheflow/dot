#!/bin/zsh

# File:      .zshrc
# Created:   22.03.2020
# Author:    Artyom Danilov


# History
# ------------------------------------------------------------------------------
export HISTFILE="${XDG_CACHE_HOME}"/zsh/history # <-- Save history here
export HISTSIZE=10000  # <-- Lines to store during interactive session
export SAVEHIST=10000  # <-- Lines to save after interactive session

# Options
# ------------------------------------------------------------------------------
# Don't type cd to change directories.
setopt autocd autopushd

# Autocompletion
# ------------------------------------------------------------------------------
autoload -Uz compinit  # <-- Mark 'compinit' as function.
zmodload zsh/complist  # <-- Load this module to enhance completion features.

_comp_options+=(globdots) # <-- Include hidden files in autocomplete.

# Do menu-driven completion. (zstyle is a builtin)
zstyle ':completion:*' menu select

# Initialize completion.
compinit -d "${XDG_CACHE_HOME}"/zsh/zcompdump-"${ZSH_VERSION}"

# Vim mode
# ------------------------------------------------------------------------------
# Enable vim bindings.
bindkey -v

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Fix bug when you can't backspace after being in vim mode.
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1  # <-- Faster enter normal mode

# Config files
# ------------------------------------------------------------------------------
# Load aliases and functions, that can be used in any posix shell.
for file in "${DOTFILES_HOME}"/shell/*; do
    . "${file}"
done

# Check if running on wsl.
if [ -n "${WSL_DISTRO_NAME}" ]; then
    # Load aliases and functions, that can only be used in  wsl.
    for file in "${DOTFILES_HOME}"/wsl/*; do
        . "${file}"
    done
fi

# Plugins
# ------------------------------------------------------------------------------
# Install zplug if not installed.
[ -d "${ZPLUG_HOME}" ] || \
    git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"

# Essential.
. "${ZPLUG_HOME}"/init.zsh && zplug update >/dev/null

zplug "zsh-users/zsh-autosuggestions"
# Highlight commands, literals, etc.
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# Suggest aliases for commands.
zplug "djui/alias-tips"
# Suggest where to install commands/programs/packages
zplug "plugins/command-not-found", from:oh-my-zsh
# Prompt theme.
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# Install packages that have not been installed yet.
zplug check || zplug install

# Load plugins.
zplug load

# Prompt
# ------------------------------------------------------------------------------
[ -f "${ZDOTDIR}"/.zshprompt ] && . "${ZDOTDIR}"/.zshprompt


# Must be at the bottom
[ -f "${HOME}"/.local/bin/virtualenvwrapper.sh ] && \
    . "${HOME}"/.local/bin/virtualenvwrapper.sh