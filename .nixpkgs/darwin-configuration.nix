{ config, pkgs, ... }:

let
  python-with-global-packages = pkgs.python3.withPackages (ps: with ps; [
    pip
  ]);
  ipythonFix = self: super: {
    python3 = super.python3.override {
      packageOverrides = pySelf: pySuper: {
        ipython = pySuper.ipython.overridePythonAttrs (old: {
          preCheck = old.preCheck + super.lib.optionalString super.stdenv.isDarwin ''
            echo '#!${pkgs.stdenv.shell}' > pbcopy
            chmod a+x pbcopy
            cp pbcopy pbpaste
            export PATH="$(pwd)''${PATH:+":$PATH"}"
          '';
        });
      };
      self = self.python3;
    };
  };
in
{
  nixpkgs.config.allowUnfree = true;
  environment.variables = { EDITOR = "nvim"; };
  nixpkgs.overlays = [ ipythonFix ];

  imports = [
    ./modules
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ python-with-global-packages ];
  programs.zsh.enable = true; # default shell on catalina

  system.activationScripts.postUserActivation.text = ''
    echo ":: -> Running vim activationScript..."
    # Handle mutable configs
    if [ ! -e "$HOME/.config/nvim/" ]; then
      echo "Linking vim folders..."
      ln -sf $HOME/dotfiles/config/nvim $HOME/.config/nvim
    fi
    if [ ! -f $HOME/.tmux.conf ]; then
        echo "Linking tmux conf..."
        ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
    fi
    if [ ! -f $HOME/.zshrc ]; then
        echo "Linking zshrc..."
        ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
    fi
    if [ ! -f $HOME/.nixpkgs/darwin-configuration.nix ]; then
        echo "Linking nixpkgs..."
        ln -s $HOME/dotfiles/.nixpkgs $HOME/.nixpkgs
    fi
    if [ ! -d /Applications/kitty.app ]; then
        echo "Linking kitty..."
        cp -r /run/current-system/Applications/* /Applications/ >/dev/null 2>&1
    fi

  '';
  system.stateVersion = 4;
}
