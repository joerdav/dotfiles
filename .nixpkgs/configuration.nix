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
  homepath = if pkgs.stdenv.isDarwin then "$HOME" else "/home/joerdav";
  script = ''
    echo ":: -> Running vim activationScript..."
    # Handle mutable configs
    if [ ! -e "${homepath}/.config/nvim/" ]; then
      echo "Linking vim folders..."
      ln -sf ${homepath}/dotfiles/config/nvim ${homepath}/.config/nvim
    fi
    if [ ! -f ${homepath}/.tmux.conf ]; then
        echo "Linking tmux conf..."
        ln -s ${homepath}/dotfiles/.tmux.conf ${homepath}/.tmux.conf
    fi
    if [ ! -f ${homepath}/.zshrc ]; then
        echo "Linking zshrc..."
        ln -s ${homepath}/dotfiles/.zshrc ${homepath}/.zshrc
    fi
    if [ ! -f ${homepath}/.oh-my-zsh ]; then
        echo "Linking omz..."
        ln -sf ${homepath}/dotfiles/.oh-my-zsh ${homepath}/.oh-my-zsh
    fi
  '' + pkgs.lib.optionalString pkgs.stdenv.isDarwin ''
    if [ ! -f ${homepath}/.nixpkgs/darwin-configuration.nix ]; then
        echo "Linking nixpkgs..."
        ln -s ${homepath}/dotfiles/.nixpkgs ${homepath}/.nixpkgs
    fi
    if [ ! -d /Applications/kitty.app ]; then
        echo "Linking kitty..."
        cp -r /run/current-system/Applications/* /Applications/ >/dev/null 2>&1
    fi
  '';

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

  system.activationScripts.postUserActivation.text = script;
}
