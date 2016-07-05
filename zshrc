# /etc/zshrc

# BASICS {{{1

autoload -Uz compinit promptinit colors
compinit
promptinit
colors

ZDOTDIR=${ZDOTDIR:-${HOME}}
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE='1000000'
SAVEHIST="${HISTSIZE}"
export EDITOR=nvim
#export TERM='rxvt-unicode'

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
alias vim='nvim'

# KEY-BINDINGS {{{1

# make home and end work
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# COMMAND NOT FOUND {{{1

if [[ -x /usr/lib/command-not-found ]] ; then
        function command_not_found_handler() {
                /usr/lib/command-not-found --no-failure-msg -- $1
        }
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
        echo -n "⎇"
        echo -n `git branch | grep '* ' | sed 's/..//'`
        echo -n " %f "
    fi
}

# PROMPT {{{1

if test "$UID" = 0; then
    PROMPT='%B%F{red}%(?..[%?] )%n%f%b %B%~%b $(git_info)%B>%b '
else
    PROMPT='%B%F{red}%(?..[%?] )%f%b%B%F{green}%n%f%b %B%~%b $(git_info)%B>%b '
fi
RPROMPT='%B%F{red}%(?..:()%f%b'  # sad smiley

# vim:foldmethod=marker:foldlevel=0:foldenable
