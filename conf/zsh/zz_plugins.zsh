function load_plugin() {
  PLUGIN=$1
  if [ -f ${PLUGIN} ]
  then
    source ${PLUGIN}
  fi
}

# packages installed plugins
# https://github.com/marlonrichert/zsh-autocomplete/blob/main/CONFIGURATION.md
load_plugin /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# Disable semicolon at the end of line
zstyle ':autocomplete:*' add-semicolon no
# This makes ← and → always move the cursor on the command line, even when you are in the menu
bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char
bindkey -M menuselect  '^[[C'  .forward-char  '^[OC'  .forward-char

load_plugin /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
load_plugin /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
load_plugin /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
