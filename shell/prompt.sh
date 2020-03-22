#!/usr/bin/zsh

# ------------------------------------------------------------------------------
# | File:      prompt.sh
# ------------------------------------------------------------------------------
# | Modified:  March 23, 2020
# ------------------------------------------------------------------------------
# | Author:    Artyom Danilov
# ------------------------------------------------------------------------------

echo "Running ${0}"

# ------------------------------------------------------------------------------
#                         Shell-dependent Definitions
# ------------------------------------------------------------------------------

# 'BASH_VERSION' only defined in bash.
if [ -n "${BASH_VERSION}" ]; then

    start_color='\[\e[38;5;'
    end_color='m\]'

    nl='\n' reset='\[\e[0m\]'

    username='\u'
    hostname='\h'
    absdir='\w'
    reldir='\W'

    # 'PROMPT_COMMAND' is a special environment variable name known to bash.
    PROMPT_COMMAND=my_prompt

# 'ZSH_VERSION' only defined in zsh.
elif [ -n "${ZSH_VERSION}" ]; then

    start_color=$'%{\e[38;5;'
    end_color='m%}'

    nl=$'\n'
    reset=$'%{\e[0m%}'

    username='%n'
    hostname='%M'
    absdir='%~'
    reldir='%1~'

    # 'precmd' is a special function name known to zsh.
    precmd() { my_prompt; }
fi

# ------------------------------------------------------------------------------
#                                    Colors
# ------------------------------------------------------------------------------

cyan="${start_color}45${end_color}"
green="${start_color}82${end_color}"
limegreen="${start_color}154${end_color}"
orange="${start_color}202${end_color}"
purple="${start_color}135${end_color}"
red="${start_color}9${end_color}"
white="${start_color}15${end_color}"
yellow="${start_color}220${end_color}"

# ------------------------------------------------------------------------------
#                                    Prompt
# ------------------------------------------------------------------------------

# Gets executed each time prompt is drawn.
my_prompt() {

    # Get last command status
    if [ $? -eq 0 ]; then
        command_status=" ${green}:)${reset}"
    else
        command_status=" ${red}:(${reset}"
    fi

    # Get git branch
    if git status >/dev/null 2>&1; then

        # Branch currently on.
        branch="$(git branch 2>/dev/null | grep "^\*" | colrm 1 2)"
        # Total number of commits in repository on branch.
        commits="$(git rev-list --count "${branch}")"

        # Returns 0 if there are untracked files in repository.
        any_untracked() {
            return $(! git ls-files -o --directory --exclude-standard | sed q);
        }

        # Returns 0 if there are modified files in repository.
        any_modified() {
                return  $( [ "$(git diff --name-only | wc -l)" -gt 0 ] );
        }

        # Colorize commits.
        if any_untracked; then
            commits="${red}U-${commits}"
        elif any_modified; then
            commits="${yellow}M-${commits}"
        else
            commits="${green}${commits}"
        fi

        # Put all together.
        branch="${cyan}${branch} ${commits}"
    else
        branch=''
    fi;

    # Set PS1
    PS1="${nl}${purple}${username}"             # username
    PS1+="${white} at ${orange}${hostname}"     # at host
    PS1+="${white} in ${limegreen}${absdir}"    # in directory
    PS1+="${white} on ${branch}"                # (branch|commits)
    PS1+="${command_status}"                    # :) or :(
    PS1+="${reset}${nl}\$ "
}

# Default
#PS1="$green\u@\h$reset:$blue\w$reset\$ "
