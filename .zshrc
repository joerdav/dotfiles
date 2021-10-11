export PATH="/run/current-system/sw/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
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

export ZSH="$HOME/.oh-my-zsh"
export VISUAL=vim
export EDITOR="$VISUAL"
export PATH="$(yarn global bin):$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export ZSH_THEME=robbyrussell

fpath=(~/dotfiles/zsh-completion $fpath)
autoload -Uz compinit && compinit

plugins=(git archlinux dotnet git-flow git-prompt node npm please vscode)

source $ZSH/oh-my-zsh.sh

alias watch="ag -l | entr"
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/joe/.sdkman"
[[ -s "/home/joe/.sdkman/bin/sdkman-init.sh" ]] && source "/home/joe/.sdkman/bin/sdkman-init.sh"
