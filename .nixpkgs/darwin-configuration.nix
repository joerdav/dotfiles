{ config, pkgs, ... }:

let

  python-with-global-packages = pkgs.python3.withPackages(ps: with ps; [
    pip
    botocore
    boto3
    numpy
    neovim
  ]);

  air = pkgs.callPackage ./air.nix {};

  nodePackages = import ./node-env/default.nix {
    inherit pkgs;
  }; 

in

{
  nixpkgs.config.allowUnfree = true;
  environment.variables = { EDITOR = "vim"; };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      air
      nodePackages."@aws-amplify/cli"
      python-with-global-packages
      pkgs.ag
      pkgs.awslogs
      pkgs.aerc
      pkgs.asciinema
      pkgs.awscli2
      pkgs.ssm-session-manager-plugin
      pkgs.aws-vault
      pkgs.docker
      pkgs.dotnetCorePackages.sdk_3_1
      pkgs.entr
      pkgs.fzf
      pkgs.gcalcli
      pkgs.gifsicle
      pkgs.git
      pkgs.gitAndTools.gh
      pkgs.gnupg
      pkgs.go
      pkgs.gopls
      pkgs.goreleaser
      pkgs.goimports
      pkgs.graphviz
      pkgs.htop
      pkgs.hugo
      pkgs.imagemagick
      pkgs.jq
      pkgs.lynx
      pkgs.mutt
      pkgs.nmap
      pkgs.nodejs-14_x
      pkgs.nodePackages.prettier
      pkgs.nodePackages.typescript
      pkgs.nodePackages.node2nix
      pkgs.oh-my-zsh
      pkgs.pass
      pkgs.ripgrep
      pkgs.terraform
      pkgs.tmux
      pkgs.tree
      pkgs.unzip
      pkgs.urlscan
      pkgs.wget
      pkgs.yarn
      pkgs.zip
      (
	pkgs.neovim.override {
	  vimAlias = true;
	  configure = {
	    customRC = builtins.readFile ./../dotfiles/.vimrc;
	  };
	}
      )
    ];

  programs.zsh.enable = true;  # default shell on catalina
  programs.zsh.ohMyZsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

