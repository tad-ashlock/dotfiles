# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam2 8bit

setopt hist_ignore_all_dups share_history
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

# The following configuration allows for searching the history for a substring.
# Additionally, the 'k' and 'j' keys will only search for history local to that
# terminal session.  While the 'K' and 'J' keys will search the global history.
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey -M vicmd 'K' history-substring-search-up
bindkey -M vicmd 'J' history-substring-search-down

function only-local-history-substring-search-up ()
{
    zle set-local-history 1
    zle history-substring-search-up
    zle set-local-history 0
}
function only-local-history-substring-search-down ()
{
    zle set-local-history 1
    zle history-substring-search-down
    zle set-local-history 0
}
zle -N only-local-history-substring-search-up
zle -N only-local-history-substring-search-down

bindkey -M vicmd 'k' only-local-history-substring-search-up
bindkey -M vicmd 'j' only-local-history-substring-search-down


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias parallel='parallel --gnu '

# Use 'trash' instead of 'rm' to delete files
alias rm='echo "This is not the command you are looking for."; false'

if [[ -f ~/.sh_sys_config ]]; then
    . ~/.sh_sys_config
fi

. ~/z.sh
