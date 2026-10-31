################### Aliases ###################

# common
alias vi=nvim
alias vim=nvim
alias ls='lsd -g'
alias ll='ls -lah'
alias l='ls -lh'
alias lr='ls -ltrh'
alias ..='cd ..'
alias grep='grep --color=tty -d skip'
alias _pgrep='ps -ef|grep $1'
alias _lscert='certutil -L -d sql:$HOME/.pki/nssdb'
alias _delcert='certutil -D -n $1 -d sql:$HOME/.pki/nssdb'
alias hgrep='history|grep -a $1'

# suffixes
alias -s {yml,yaml}=nvim # writting filename with such extenstions will open in nvim

# lazygit
alias lz='lazygit'

# mkdir and cd
mkcd() {
  mkdir -p $1 && \
  cd $1
}

# chpwd hook
chpwd() {
  ls -l
}

# global aliases - Use anywhere in commands
# sample NE sends 2 to /dev/null by typing e.g.: `du -sh / NE`
alias -g NE='2>/dev/null'
alias -g NUL='>/dev/null 2&1'
alias -g B64='| base64'
alias -g B64D='| base64 -d'
alias -g JQ='| jq .'
alias -g YQ='| yq .'
alias -g BJQ='| jq . | bat -p -l json'
alias -g BYQ='| yq . | bat -p -l yaml'

# alias for pipe manpages into bat
mann() {
  man $1 | bat -p -l man
}

# git
alias g='git'
alias ga='git add'
alias gco='git checkout'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias gst='git status'
