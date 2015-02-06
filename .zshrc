# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam2 8bit

setopt hist_ignore_all_dups sharehistory
setopt extended_glob

# Use vi keybindings
bindkey -v
alias info='info --vi-keys'

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000000
SAVEHIST=1000000000
HISTFILE=~/.zsh/history

alias ls='ls -F'
alias ll='ls -lF'
alias la='ls -A'
alias lla='ls -AlF'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    # Change the color used by 'ls' for executable files.
    # This is only needed for the Solarized color scheme.
    export LS_COLORS=`echo $LS_COLORS | sed 's/ex=[^:]*/ex=00;31/g'`

    alias ls='ls -F --color=always'
    alias ll='ls -lF --color=always'
    alias la='ls -A --color=always'
    alias lla='ls -AlF --color=always'

    alias grep='grep --color=always'
    alias fgrep='fgrep --color=always'
    alias egrep='egrep --color=always'
fi

# enable color support of less
alias less='less -R'


# Use modern completion system
autoload -Uz compinit
compinit -d ~/.zsh/zcompdump

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source ~/.zsh/plugins/opp.zsh/opp.zsh
source ~/.zsh/plugins/opp.zsh/opp/*.zsh

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias parallel='parallel --gnu '


if [[ -f ~/.sh_sys_config ]]; then
    . ~/.sh_sys_config
fi
