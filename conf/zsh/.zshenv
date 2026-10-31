# ~/.config/zsh/.zshenv

# ---------- XDG base directories ----------
# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- Editor ----------
# Default editor used by git, crontab, etc.
export EDITOR="nvim"
export VISUAL="nvim"

# ---------- Pager ----------
if (( $+commands[bat])); then
  # not all bat themes support flags highlighting
  export MANPAGER="bat --language=man --style=plain --strip-ansi=always --theme='Monokai Extended'"
  # export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=\"Monokai Extended\"'"
  # export MANROFFOPT="-c"
fi


# ---------- Prompt ----------
# avoid % sign on command output
# https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
export PROMPT_EOL_MARK=''


# ---------- GPG ----------
# Ensure GPG_TTY is correct
export GPG_TTY=$(tty)

# Ensure GPG_TTY is updated when switching to new tmux panes/windows
preexec() { export GPG_TTY=$(tty); }
precmd()  { export GPG_TTY=$(tty); }

# Force refresh GPG_TTY on shell init
GPG_TTY_COMMAND="export GPG_TTY=\$(tty)"
if [[ -n "$TMUX" ]]; then
    tmux set-environment -g GPG_TTY $(tty) 2>/dev/null
fi
eval "$GPG_TTY_COMMAND"
