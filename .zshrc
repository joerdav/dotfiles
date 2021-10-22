#zmodload zsh/zprof
export PATH="/run/current-system/sw/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export VISUAL=vim
export EDITOR="$VISUAL"
export PATH="$(yarn global bin):$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export ZSH_THEME=eastwood

if [ ! -f $HOME/.tmux.conf ]; then
    ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
fi
if [ ! -f $HOME/.zshrc ]; then
    ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
fi
if [ ! -f $HOME/.nixpkgs/darwin-configuration.nix ]; then
    ln -s $HOME/dotfiles/.nixpkgs $HOME/.nixpkgs
fi
if [ ! -f $HOME/.config/nvim/coc-settings.json ]; then
    ln -s $HOME/dotfiles/coc-settings.json $HOME/.config/nvim/coc-settings.json
fi

# Add pass autocomplete.
fpath=(~/dotfiles/zsh-completion $fpath)
autoload -Uz compinit
# Cache for 1 day.
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

plugins=(git web-search)

source $ZSH/oh-my-zsh.sh

alias watch="ag -l | entr"
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/joe/.sdkman"
[[ -s "/home/joe/.sdkman/bin/sdkman-init.sh" ]] && source "/home/joe/.sdkman/bin/sdkman-init.sh"
#zprof
