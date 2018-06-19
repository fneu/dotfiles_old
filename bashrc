#
# ~/.bashrc
#
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Add blur for yakuake
if [[ $(ps --no-header -p $PPID -o comm) =~ yakuake|konsole ]];
then         
        for wid in $(xdotool search --pid $PPID);
        do
                xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid;
        done; 
fi


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# FZF fuzzy file search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ls colors
LS_COLORS="$LS_COLORS:ow=1;34;47:"
alias ls='ls --color=auto --group-directories-first'

#less
export LESS='-MRi#8j.5'
#             |||| `- center on search matches
#             |||`--- scroll horizontally 8 columns at a time
#             ||`---- case-insensitive search unless pattern contains uppercase
#             |`----- parse color codes
#             `------ show more information in promp

# grep
alias grep='grep --color --binary-files=without-match --exclude-dir .git'

# git
alias g='git'
complete -o default -o nospace -F _git g
. /usr/share/bash-completion/completions/git 2> /dev/null

# vim
alias v='vim'

# alert
# Show a desktop notification when a command finishes. Use like this:
#   sleep 5; alert
function alert() {
    if [ $? = 0 ]; then icon=terminal; else icon=error; fi
    last_cmd="$(history | tail -n1 | sed 's/^\s*[0-9]*\s*//' | sed 's/;\s*alert\s*$//')"
    notify-send -i $icon "$last_cmd"
}

# simplified python virtual env mangling
alias lsvenv='ls ~/.venv'
alias unvenv='deactivate'
mkvenv() {
	mkdir -p ~/.venv
	python3 -m venv ~/.venv/"$1"
}
rmvenv() {
	rm -rf ~/.venv/"$1"
}
venv() {
	source ~/.venv/"$1"/bin/activate
}

# SETTINGS

# shell history is useful, let's have more of it
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups   # don't store duplicated commands
shopt -s histappend # don't overwrite history file after each session

# run cnf on unknown command (openSUSE)
export COMMAND_NOT_FOUND_AUTO=1

# let Ctrl-O open ranger, a console file manager (http://nongnu.org/ranger/):
bind '"\C-o":"ranger\C-m"'
# this wrapper lets bash automatically change current directory to the last one
# visited inside ranger.  (Use "cd -" to return to the original directory.)
function ranger {
    tempfile="$(mktemp)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" && cd -- "$(cat "$tempfile")"
    rm -f -- "$tempfile"
}

# Prompt

# custom virtualenv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
virtualenv_info() {
    [[ -n "$VIRTUAL_ENV" ]] && echo "(\[\033[0;31m\]${VIRTUAL_ENV##*/}\[\033[0m\])"
}

# custom git prompt
git_info() {
    local DIRTY="\[\033[0;33m\]"
    local CLEAN="\[\033[0;32m\]"
    local UNMERGED="\[\033[0;31m\]"
    git rev-parse --git-dir >& /dev/null
    if [[ $? == 0 ]]; then
        echo -n " "
        if [[ `git ls-files -u >& /dev/null` == '' ]]; then
            git diff --quiet >& /dev/null
            if [[ $? == 1 ]]
            then
                echo -n $DIRTY
            else
                git diff --cached --quiet >& /dev/null
                if [[ $? == 1 ]]; then
                    echo -n $DIRTY
                else
                    echo -n $CLEAN
                fi
            fi
        else
            echo -n $UNMERGED
        fi
        echo -n `git branch | grep '* ' | sed 's/..//'`
        echo -n "\[\033[0m\]"
    fi
}

#PS1='[\u@\h \W]\$ '

set_bash_prompt(){
	PS1="$(virtualenv_info)\[\033[1;35m\]\u\[\033[0m\]@\[\033[1;34m\]\H\[\033[0m\]:\[\033[1;36m\]\w\[\033[0m\]$(git_info)> "
}

PROMPT_COMMAND=set_bash_prompt