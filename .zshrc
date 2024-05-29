zmodload zsh/zprof

# Environment Variables
export PATH="$PATH:/run/current-system/sw/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/src/golang/go/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/dotfiles/scripts"
export ZSH="$HOME/.oh-my-zsh"
export VISUAL=vim
export EDITOR="$VISUAL"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color=fg:#ffffff,bg:#000000,hl:#ffffff
 --color=fg+:#ffffff,bg+:#000000,hl+:#ffffff
 --color=info:#ffffff,prompt:#ffffff,pointer:#ffffff
 --color=marker:#ffffff,spinner:#ffffff,header:#ffffff'
export CLICOLOR=1
GPG_TTY=$(tty)
export GPG_TTY

# Auto Completion
fpath=(~/dotfiles/zsh-completion $fpath)
autoload -Uz compinit
autoload -U +X bashcompinit && bashcompinit
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
    if [ -n $vcs_info_msg_0_ ]; then
    TICKET_RESULT=$(c -p)
	    if [ -n "$TICKET_RESULT" ]; then
		TICKET_RESULT="[$TICKET_RESULT]"
	    fi
    fi
}
PROMPT='[%?][%~% ]${vcs_info_msg_0_}${TICKET_RESULT}%B$%b '
RPROMPT=''

# oh-my-zsh
plugins=(git web-search)
ZSH_WEB_SEARCH_ENGINES=(
  phind "https://www.phind.com/agent?q="
)
source $ZSH/oh-my-zsh.sh

SECRETS=~/.secrets
if test -f "$SECRETS"; then
  source $SECRETS
fi

bindkey -s ^f "tmux-sessionizer\n"


alias watch="ag -l | entr"
alias es="exercism submit"
alias j="dir=\$(find ~/src -maxdepth 3 -name .git -type d -prune -exec dirname {} \; | fzf +m) && cd \"\$dir\""
alias lg="nvim -c :G"
alias lazygit="nvim -c :G"
alias ph="web_search phind"
alias gvim="nvim --listen 127.0.0.1:55644"

cw() {
  group=$(aws-vault exec $1 -- saw groups | fzf +m)
  echo "saw watch --expand $group"
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
bwcopy() {
  if hash bw 2>/dev/null; then
    bw get item "$(bw list items | jq '.[] | "\(.name) | username: \(.login.username) | id: \(.id)" ' | fzf-tmux | awk '{print $(NF -0)}' | sed 's/\"//g')" | jq '.login.password' | sed 's/\"//g' | pbcopy
  fi
}
x() {
  xc $(xc -s |  fzf --preview 'xc -d {} | glow --style dark')
}
eval "$(direnv hook zsh)"
eval "$(atuin init zsh)"

complete -o nospace -C /Users/joe.davidson/go/bin/xc xc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/joe/.sdkman"
[[ -s "/home/joe/.sdkman/bin/sdkman-init.sh" ]] && source "/home/joe/.sdkman/bin/sdkman-init.sh"

#zprof

