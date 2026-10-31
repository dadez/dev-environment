autoload -U add-zsh-hook

function _interactive_sofa() {
  emulate -L zsh
  zle -I

  echoti rmkx
  output=$(sofa -i)
  echoti smkx

  if [[ -n $output ]]; then
    LBUFFER=$output
  fi

  zle reset-prompt
}

if [ -d $HOME/.luarocks ]; then
  export PATH="${HOME}/.luarocks/bin:${PATH}"
fi

zle -N _interactive_sofa_widget _interactive_sofa
bindkey '^o' _interactive_sofa_widget
