
# =========================================================
# History
# =========================================================
HISTFILE=~/.state/zsh/sh_history
HISTSIZE=10000  # Save most-recent 10000 lines
SAVEHIST=10000  # Save most-recent 10000 lines

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# =========================================================
# Shell behaviour
# =========================================================
# oh-my-zsh defaults
# Changing Directories
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
# Completion
setopt ALWAYS_TO_END
setopt COMPLETE_IN_WORD
# Input / Output
setopt INTERACTIVE_COMMENTS
setopt NO_FLOW_CONTROL
# Shell State
setopt LOGIN
# Job Control
setopt LONG_LIST_JOBS
# Pronmpting
setopt PROMPT_SUBST

# =========================================================
# Completion
# =========================================================
fpath+=("$HOME/.local/share/zsh/site-functions")

# Load completion system
autoload -Uz compinit

compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump"

# # Enable interactive completion menu selection
zstyle ':completion:*' menu select
#
# # Make completion case-insensitive
# # Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower

# =========================================================
# Cached tool intialization
# =========================================================
# Runs `tool init zsh` once, caches the output, regenerates
# when the binary changes.
_zsh_cached_init() {
  emulate -L zsh
  local bin=$1; shift
  local dump=$XDG_CACHE_HOME/zsh/$bin-init.zsh
  if [[ ! -s $dump || ( -n $commands[$bin] && $commands[$bin] -nt $dump ) ]]; then
    (( $+commands[$bin] )) || return 1
    mkdir -p $dump:h
    "$@" >| $dump
  fi
  [[ -s $dump ]] && source $dump
}

# =========================================================
# Modular configurations
# =========================================================
# load zsh files.
for config (~/.config/zsh/*.zsh) . $config



# =========================================================
# FZF
# =========================================================
if (( $+commands[fzf] ))
then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh

  # UI
  export FZF_DEFAULT_OPTS='
    --layout=reverse
    --inline-info
    --border=bold
    --border=rounded
    --margin=3%
    --color=dark
  '

  # use fd
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'  # strip-cwd-prefix removes the leading ./ from results
  # Ctrl-T uses fd
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  # use bat for preview
  export _FZF_PREVIEW_CMD='bat --color=always --style=plain --line-range=:500 {}'
  export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"

  # Ctrl+F: file picker excluding hidden files
  _fzf_file_no_hidden() {
    local cmd result
    cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
    result=$(eval "${cmd:-fd . --type file}" | fzf --preview "$_FZF_PREVIEW_CMD") \
      && LBUFFER+="$result"  # LBUFFER is the text left of the cursor
    zle reset-prompt
  }
  zle -N _fzf_file_no_hidden
  bindkey -M emacs '^F' _fzf_file_no_hidden
  bindkey -M viins '^F' _fzf_file_no_hidden
  
  # tv overrides ^R
  # Set at the bottom of the file
 bindkey -M emacs '^R' fzf-history-widget
 bindkey -M viins '^R' fzf-history-widget
fi

