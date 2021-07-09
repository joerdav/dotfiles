{ config, pkgs, ... }:

let

  python-with-global-packages = pkgs.python3.withPackages(ps: with ps; [
    pip
  ]);

  air = pkgs.callPackage ./air.nix {};
  slides = pkgs.callPackage ./slides.nix {};

in

{
  nixpkgs.config.allowUnfree = true;
  environment.variables = { EDITOR = "vim"; };
  
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      air
      slides
      python-with-global-packages
      pkgs.ag
      pkgs.aerc
      pkgs.alacritty
      pkgs.asciinema
      pkgs.ssm-session-manager-plugin
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
	  pkgs.google-cloud-sdk
      pkgs.gopls
      pkgs.goreleaser
      pkgs.goimports
      pkgs.graphviz
      pkgs.htop
      pkgs.hugo
      pkgs.imagemagick
      pkgs.jq
      pkgs.lynx
      pkgs.lazygit
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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

