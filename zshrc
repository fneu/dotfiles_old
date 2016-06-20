# /etc/zshrc

# BASICS #######################################################################

autoload -Uz compinit promptinit colors
compinit
promptinit
colors

ZDOTDIR=${ZDOTDIR:-${HOME}}
HISTFILE="${ZDOTDIR}/.zsh_history"
HISTSIZE='10000'
SAVEHIST="${HISTSIZE}"
export EDITOR=vim
export TERM='rxvt-unicode'

# OPTIONS ######################################################################

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

# ALIASES ######################################################################

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias mkdir="mkdir -v"
alias grep='grep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'

alias gimme='sudo zypper in'

# KEY-BINDINGS #################################################################

# make home and end work
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# COMMAND NOT FOUND ############################################################

if [[ -x /usr/lib/command-not-found ]] ; then
        function command_not_found_handler() {
                /usr/lib/command-not-found --no-failure-msg -- $1
        }
fi

# THEFUCK ######################################################################

# https://github.com/nvbn/thefuck
test -s ~/.alias && . ~/.alias || true
eval "$(thefuck --alias fuck)"

# GIT ##########################################################################

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

# PROMPT #######################################################################

if test "$UID" = 0; then
    PROMPT='%B%F{red}%(?..[%?] )%n%f%b %B%~%b $(git_info)%B❯%b '
else
    PROMPT='%B%F{red}%(?..[%?] )%f%b%B%F{green}%n%f%b %B%~%b $(git_info)%B❯%b '
fi
RPROMPT='%B%F{red}%(?..:()%f%b'  # sad smiley

# VIM GOODNESS #################################################################
bindkey -v
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    #VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    VIM_PROMPT="%F{red}"
    zle reset-prompt
    if test "$UID" = 0; then
        PROMPT='%B%F{red}%(?..[%?] )%n%f%b %B%~%b $(git_info)%B${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}❯%b%f '
    else
        PROMPT='%B%F{red}%(?..[%?] )%f%b%B%F{green}%n%f%b %B%~%b $(git_info)%B${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}❯%b%f '
    fi
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
