#zmodload zsh/zprof

# Environment Variables
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/run/current-system/sw/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$(yarn global bin):$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/bin"
export ZSH="$HOME/.oh-my-zsh"
export VISUAL=vim
export EDITOR="$VISUAL"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#ffffff,bg:#000000,hl:#ffffff
 --color=fg+:#ffffff,bg+:#000000,hl+:#ffffff
 --color=info:#ffffff,prompt:#ffffff,pointer:#ffffff
 --color=marker:#ffffff,spinner:#ffffff,header:#ffffff'

# Auto Completion
fpath=(~/dotfiles/zsh-completion $fpath)
autoload -Uz compinit
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C xc xc
comp_last_updated=`date -r ~/.zcompdump +%s` &> /dev/null;
now=$(date +%s)
file_age=$((now - comp_last_updated))
if [[ $file_age -gt 86400 ]]; then;
  echo "Updating completion..."
  compinit;
  complete -C 'aws_completer' aws;
else
  compinit -C;
fi;

if grep prefix ~/.npmrc &> /dev/null;
then
  echo "prefix=$HOME/.npm-global" >> ~/.npmrc
  export PATH=$PATH:~/.npm-global/bin
fi

autoload -Uz vcs_info
setopt prompt_subst
unsetopt PROMPT_SP
zstyle ':vcs_info:git*' formats "[%b]"
precmd() {
    vcs_info
}
PROMPT='[%?][%~% ]${vcs_info_msg_0_}%B$%b '
RPROMPT=''

# oh-my-zsh
plugins=(git web-search)
source $ZSH/oh-my-zsh.sh


alias watch="ag -l | entr"
alias es="exercism submit"
alias j="dir=\$(find ~/src -maxdepth 3 -name .git -type d -prune -exec dirname {} \; | fzf +m) && cd \"\$dir\""
alias lg="nvim -c :G"
alias lazygit="nvim -c :G"

cw() {
  group=$(aws-vault exec $1 -- saw groups | fzf +m)
  echo "aws-vault exec $1 -- saw watch --expand $group"
  aws-vault exec $1 -- saw watch --expand $group
}
notif() {
  osascript -e "display notification \"$1\""
}
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
feach() {
  find . -depth 2 -name go.mod -type f -exec dirname {} \; | xargs -L1 -I % zsh -c "echo %;cd %;$@"
}
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C xc xc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/joe/.sdkman"
[[ -s "/home/joe/.sdkman/bin/sdkman-init.sh" ]] && source "/home/joe/.sdkman/bin/sdkman-init.sh"
#zprof

