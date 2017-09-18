# /etc/zshrc

# BASICS {{{1

autoload -Uz compinit promptinit colors bashcompinit
compinit
promptinit
colors
bashcompinit

ZDOTDIR=${ZDOTDIR:-${HOME}}
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE='1000000'
SAVEHIST="${HISTSIZE}"

export EDITOR=nvim
export PATH=$PATH:/home/fabian/bin/ngrok
#export TERM='rxvt-unicode'

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# eval "$(register-python-argcomplete coala)"

# FZF {{{

# Use FZF for ** completion and CTRL-R history search
# add '-L' to default command to follow symlinks
export FZF_DEFAULT_COMMAND="find -L * -path '*/\.*' -prune -o -type f -print -o -type l -print 2> /dev/null"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# OPTIONS {{{1

setopt correctall            # Automagically correct inputs

setopt promptsubst           # Turn on command substitution in the prompt

setopt interactivecomments   # Ignore lines prefixed with '#'

setopt hist_ignore_all_dups  # Ignore duplicate in history.
setopt hist_ignore_space     # No record in history if preceded with a space
setopt share_history         # One history to rule all instances

setopt auto_cd               # Perform cd command when only a directory is given

setopt extended_glob         # Coala style globs with (a|b)...
setopt noglobdots            # ... which never match dotfiles

setopt nobeep                # Stop being annoying

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{green}%d%f%u'

# ALIASES {{{1
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias mkdir="mkdir -v"
alias grep='grep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'

alias fuck='sudo !!'
alias gimme='sudo zypper in'
alias update='sudo zypper dup --no-allow-vendor-change'

#devel GitMate:
alias backend='cd ~/devel/gitmate-2 && ./init.sh'
alias frontend='cd ~/devel/gitmate-2-frontend && ng serve'

# KEY-BINDINGS {{{1

# make home and end work
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
# Rebind the insert key.  I really can't stand what it currently does.
bindkey '\e[2~' overwrite-mode
# Rebind the delete key. Again, useless.
bindkey '\e[3~' delete-char

# COMMAND NOT FOUND {{{1

if test -f /etc/zsh_command_not_found ; then
            . /etc/zsh_command_not_found
fi

# GIT {{{1

git_info() {
    local DIRTY="%F{yellow}"
    local CLEAN="%F{green}"
    local UNMERGED="%F{red}"
    git rev-parse --git-dir >& /dev/null
    if [[ $? == 0 ]]; then
        #echo -n "("
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
        echo -n " %f"
    fi
}

# PROMPT {{{1

if test "$UID" = 0; then
    PROMPT='%B%F{red}%(?..[%?])%f%b %F{red}%B%~%f%b $(git_info)%B>%b '
elif [ $(hostname) = "moon" ]; then
    PROMPT='%B%F{red}%(?..[%?])%f%b %F{yellow}%B%~%f%b $(git_info)%B>%b '
else
    PROMPT='%B%F{red}%(?..[%?])%f%b %B%~%b $(git_info)%B>%b '
fi
RPROMPT='%B%F{red}%(?..:()%f%b'  # sad smiley

# vim:foldmethod=marker:foldlevel=0:foldenable
