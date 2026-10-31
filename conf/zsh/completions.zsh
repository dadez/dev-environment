local dump=$XDG_CACHE_HOME/zsh/completions.zsh
local stale=0
(( $+commands[kubectl] )) && [[ $dump -nt $commands[kubectl] ]] || stale=1
(( $+commands[helm] ))    && [[ $dump -nt $commands[helm] ]]    || stale=1
(( $+commands[oc] ))      && [[ $dump -nt $commands[oc] ]]      || stale=1
if (( stale )) || [[ ! -f $dump ]]; then
  mkdir -p $dump:h
  { (( $+commands[kubectl] )) && kubectl completion zsh
    (( $+commands[helm] ))    && helm completion zsh
    (( $+commands[oc] ))      && oc completion zsh
  } > $dump
fi
source $dump
