# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                       _               _
#                      | |__   __ _ ___| |__  _ __ ___
#                      | '_ \ / _` / __| '_ \| '__/ __|
#                      | |_) | (_| \__ \ | | | | | (__
#                      |_.__/ \__,_|___/_| |_|_|  \___|
#
# ----------------------------------------------------------------------------
# | File: .bashrc
# ----------------------------------------------------------------------------
# | Modified: March 20, 2020
# ----------------------------------------------------------------------------
# | Author: Artyom Danilov
# ----------------------------------------------------------------------------
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

echo 'Running ~/.bashrc'

# If not running interactively, don't do anything
case $- in
    *i*)
          ;;
      *)
          return ;;
esac

# ---------------------------------------------------------------------------- #
#                                 Color prompt                                 #
# ---------------------------------------------------------------------------- #

case "${TERM}" in
    xterm-color | *-256color)
        color_prompt='yes' ;;
esac

force_color_prompt='yes'

if [ -n "${force_color_prompt}" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt='yes'
    else
        color_prompt=''
    fi
fi

# ---------------------------------------------------------------------------- #
#                                Shell Options                                 #
# ---------------------------------------------------------------------------- #

# Append to the history file, don't overwrite it.
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Enable changing directories without typind 'cd'
shopt -s autocd

# Minor errors in the spelling of the directory will be corrected
shopt -s cdspell

# Enable spelling correction on directory names during word completion
shopt -s dirspell

# Enable matching files in a case-insensitive fashion when performing path
# name expansion
shopt -s nocaseglob

# Change terminal characteristics.
# For ctrl mappings in vim (?)
stty -ixon

# ---------------------------------------------------------------------------- #
#                                    Prompt                                    #
# ---------------------------------------------------------------------------- #

if [ "${color_prompt}" = 'yes' ]; then
    [ -f "${HOME}/.prompt.sh" ] && . "${HOME}/.prompt.sh"
else
    PS1='\u@\h:\w\$ '
fi

# ---------------------------------------------------------------------------- #
#                        Aliases - Exports - Functions                         #
# ---------------------------------------------------------------------------- #

for file in 'aliases' 'exports' 'functions'; do
    [ -f "${HOME}/.${file}.sh" ] && . "${HOME}/.${file}.sh"
done

# ---------------------------------------------------------------------------- #
#                                     WSL                                      #
# ---------------------------------------------------------------------------- #

# If running on wsl:
if grep -qEi '(Microsoft|WSL)' /proc/version > /dev/null 2>&1; then
    [ -f "${HOME}/.wsl.sh" ] && . "${HOME}/.wsl.sh"
fi
