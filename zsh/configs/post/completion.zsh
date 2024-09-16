# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion; use cache if updated within 24h
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit -d $HOME/.zcompdump;
else
  compinit -C;
fi;

# Case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# Automatically find new executables in path
zstyle ':completion:*' rehash true
# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{red}%d%f%u'
zstyle ':completion:*:manuals' separate-sections true
# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Speed up completions
zstyle ':completion:*:paths' accept-exact '*(N)'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.cache/zcache

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $(whoami) -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

# disable zsh bundled function mtools command mcd
# which causes a conflict.
compdef -d mcd

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit
