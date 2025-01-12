export EZA_STRICT=false

export RUBYOPT="-W:deprecated -W:performance --yjit --debug-frozen-string-literal"

export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --color always --exclude .git"
export FZF_DEFAULT_OPTS="--multi --ansi"

export MAKEFLAGS="--jobs=$(sysctl -n hw.ncpu)"
