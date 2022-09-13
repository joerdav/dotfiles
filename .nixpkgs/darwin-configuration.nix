{ config, pkgs, ... }:

let
  xc = pkgs.callPackage ./xc.nix { };
  nvim = pkgs.callPackage ./nvim.nix {};
  templ = pkgs.callPackage ./templ.nix { };
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
  go = pkgs.callPackage ./go.nix {};
in
  {
    nixpkgs.config.allowUnfree = true;
    environment.variables = { EDITOR = "nvim"; };


  #nixpkgs.overlays = [
  #(import (builtins.fetchTarball {
  #url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #}))
  #];

  nixpkgs.overlays = [ipythonFix];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      python-with-global-packages
      pkgs.asciinema
      pkgs.aws-vault
      pkgs.ccls
      pkgs.cht-sh
      pkgs.dotnetCorePackages.sdk_3_1
      pkgs.discord
      pkgs.entr
      pkgs.exercism
      pkgs.ffmpeg
      pkgs.fzf
      pkgs.gawk
      pkgs.gdb
      pkgs.gh
      pkgs.git
      pkgs.gitAndTools.gh
      pkgs.gnupg
      go
      pkgs.go-swagger
      pkgs.gotools
      pkgs.gomodifytags
      pkgs.google-cloud-sdk
      pkgs.gopls
      pkgs.goreleaser
      pkgs.graphviz
      pkgs.gv
      pkgs.html-tidy
      pkgs.htop
      pkgs.jq
      pkgs.kitty
      pkgs.lua
      pkgs.luarocks
      pkgs.ngrok
      pkgs.nixpkgs-fmt
      pkgs.nix-prefetch
      pkgs.nmap
      pkgs.nodePackages.node2nix
      pkgs.nodePackages.prettier
      pkgs.nodePackages.typescript
      pkgs.nodejs-14_x
      pkgs.oh-my-zsh
      pkgs.pass
      pkgs.protobuf
      pkgs.ripgrep
      pkgs.rustfmt
      pkgs.rust-analyzer
      pkgs.silver-searcher
      pkgs.ssm-session-manager-plugin
      pkgs.tmate
      pkgs.tmux
      pkgs.tree
      pkgs.unzip
      pkgs.vscode
      pkgs.wget
      pkgs.wrk
      pkgs.yarn
      pkgs.zip
      nvim
      xc
    ];
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
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
