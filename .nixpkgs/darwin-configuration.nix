{ config, pkgs, ... }:

let
  python-with-global-packages = pkgs.python3.withPackages (ps: with ps; [
    pip
  ]);
  symbols-outline = pkgs.vimUtils.buildVimPlugin {
    name = "symbols-outline";
    src = pkgs.fetchFromGitHub {
      owner = "simrat39";
      repo = "symbols-outline.nvim";
      rev = "a1bbef84b7c7240f88092c57732c5b8eb6f48234";
      sha256 = "0vai0p365hwjs8vzadfgx66ax6jdx6pivfzzjr5v63c83kc466hq";
    };
  };
  coverage = pkgs.vimUtils.buildVimPlugin {
    name = "vim-coverage";
    src = pkgs.fetchFromGitHub {
      owner = "ruanyl";
      repo = "coverage.vim";
      rev = "1d4cd01e1e99d567b640004a8122be8105046921";
      sha256 = "1vr6ylppwd61rj0l7m6xb0scrld91wgqm0bvnxs54b20vjbqcsap";
    };
  };
  nvim-cmp = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-cmp";
    version = "2021-10-06";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "nvim-cmp";
      rev = "a39f72a4634e4bb05371a6674e3e9218cbfc6b20";
      sha256 = "04ksgg491nmyy7khdid9j45pv65yp7ksa0q7cr7gvqrh69v55daj";
    };
    meta.homepage = "https://github.com/hrsh7th/nvim-cmp/";
  };
  cmp-buffer = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "cmp-buffer";
    version = "2021-09-02";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-buffer";
      rev = "5dde5430757696be4169ad409210cf5088554ed6";
      sha256 = "0fdywbv4b0z1kjnkx9vxzvc4cvjyp9mnyv4xi14zndwjgf1gmcwl";
    };
    meta.homepage = "https://github.com/hrsh7th/cmp-buffer/";
  };
  cmp-vsnip = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "cmp-vsnip";
    version = "2021-08-25";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-vsnip";
      rev = "1588c35bf8f637e8f5287477f31895781858f970";
      sha256 = "0q3z0f7d53cbqidx8qd3z48b46a83l5ay54iw525w22j1kki3aaw";
    };
    meta.homepage = "https://github.com/hrsh7th/cmp-vsnip/";
  };
  cmp-nvim-lsp = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "cmp-nvim-lsp";
    version = "2021-09-30";
    src = pkgs.fetchFromGitHub {
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      rev = "f93a6cf9761b096ff2c28a4f0defe941a6ffffb5";
      sha256 = "02x4jp79lll4fm34x7rjkimlx32gfp2jd1kl6zjwszbfg8wziwmx";
    };
    meta.homepage = "https://github.com/hrsh7th/cmp-nvim-lsp/";
  };
  instant-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "instant-nvim";
    version = "2021-09-30";
    src = pkgs.fetchFromGitHub {
      owner = "jbyuki";
      repo = "instant.nvim";
      rev = "c883f0bc9e580b12e67291092027b5174d18e724";
      sha256 = "0lcq2ma2jr646r67lmpwcwdr3l6z0va5452g74qyzi80hv3ypgff";
    };
  };
  cht-sh-vim = pkgs.vimUtils.buildVimPlugin {
    name = "cht-sh-vim";
    src = pkgs.fetchFromGitHub {
      owner = "dbeniamine";
      repo = "cheat.sh-vim";
      rev = "e0fe468d872025477462ac5d96432f5c1aee3a0d";
      sha256 = "0imk50zibfqafylz654hm8czdalc8kyqbmayv6bj1x1a1ryk02kb";
    };
  };
  easygrep = pkgs.vimUtils.buildVimPlugin {
    name = "vim-easygrep";
    src = pkgs.fetchFromGitHub {
      owner = "dkprice";
      repo = "vim-easygrep";
      rev = "d0c36a77cc63c22648e792796b1815b44164653a";
      sha256 = "0y2p5mz0d5fhg6n68lhfhl8p4mlwkb82q337c22djs4w5zyzggbc";
    };
  };
  vimBuilder = pkgs.vimUtils.buildVimPlugin {
    name = "builder.vim";
    src = pkgs.fetchFromGitHub {
      owner = "b0o";
      repo = "builder.vim";
      rev = "940e0deff0fb4ff2c4fdfe263cdbe669152688c6";
      sha256 = "1synvwz7xqy68wb45rdy5lscp2z19wdd7wnp07smylv4jcnlya51";
    };
  };
  formatterNvim = pkgs.vimUtils.buildVimPlugin {
    name = "formatter.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "mhartington";
      repo = "formatter.nvim";
      rev = "51f10c8acc610d787cad2257224cee92b40216e5";
      sha256 = "15jkrypcd3fa6vcz035yvcpd1rfrxcwvp93mqnihm0g1a74klrql";
    };
  };
  vimTempl = pkgs.vimUtils.buildVimPlugin {
    name = "templ.vim";
    src = pkgs.fetchFromGitHub {
      owner = "Joe-Davidson1802";
      repo = "templ.vim";
      rev = "2d1ca014c360a46aade54fc9b94f065f1deb501a";
      sha256 = "1bc3p0i3jsv7cbhrsxffnmf9j3zxzg6gz694bzb5d3jir2fysn4h";
    };
  };
  vimwikiSync = pkgs.vimUtils.buildVimPlugin {
    name = "vimwiki-sync";
    src = pkgs.fetchFromGitHub {
      owner = "Joe-Davidson1802";
      repo = "vimwiki-sync";
      rev = "c53ced538bec0dfb03b2d82e14ac6fdc85dae2ec";
      sha256 = "1x57z3k6854x626w4fd5cy6yfljrrirm7ig6vp5rdfr3v809zldz";
    };
  };
in
{
  nixpkgs.config.allowUnfree = true;
  environment.variables = { EDITOR = "nvim"; };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      python-with-global-packages
      pkgs.aerc
      pkgs.ag
      pkgs.alacritty
      pkgs.asciinema
      pkgs.aws-vault
      pkgs.bats
      pkgs.ccls
      pkgs.cht-sh
      pkgs.docker
      pkgs.dotnetCorePackages.sdk_3_1
      pkgs.entr
      pkgs.exercism
      pkgs.fzf
      pkgs.gcalcli
      pkgs.gifsicle
      pkgs.git
      pkgs.gitAndTools.gh
      pkgs.gnupg
      pkgs.go
      pkgs.go-swagger
      pkgs.goimports
      pkgs.gomodifytags
      pkgs.google-cloud-sdk
      pkgs.gopls
      pkgs.goreleaser
      pkgs.graphviz
      pkgs.htop
      pkgs.hugo
      pkgs.imagemagick
      pkgs.jq
      pkgs.lazygit
      pkgs.lima
      pkgs.lua
      pkgs.luarocks
      pkgs.lynx
      pkgs.mutt
      pkgs.ngrok
      pkgs.nixpkgs-fmt
      pkgs.nmap
      pkgs.nodePackages.node2nix
      pkgs.nodePackages.prettier
      pkgs.nodePackages.typescript
      pkgs.nodejs-14_x
      pkgs.oh-my-zsh
      pkgs.pass
      pkgs.ripgrep
      pkgs.ssm-session-manager-plugin
      pkgs.stylua
      pkgs.terraform
      pkgs.tmate
      pkgs.tmux
      pkgs.tree
      pkgs.twtxt
      pkgs.unzip
      pkgs.urlscan
      pkgs.vscode
      pkgs.wget
      pkgs.wrk
      pkgs.yarn
      pkgs.zip
      (
        pkgs.neovim.override {
          vimAlias = true;
          configure = {
            packages.myPlugins = with pkgs.vimPlugins; {
              start = [
                cht-sh-vim
                cmp-buffer
                cmp-nvim-lsp
                cmp-vsnip
                coverage #ruanyl/coverage.vim
                easygrep #dkprice/vim-easygrep
                formatterNvim
                friendly-snippets
                fzf-vim
                instant-nvim
                nerdcommenter #preservim/nerdcommenter
                nvim-cmp
                nvim-lspconfig #https://neovim.io/doc/user/lsp.html#lsp-extension-example
                nvim-treesitter
                nvim-web-devicons
                symbols-outline
                trouble-nvim
                vim-abolish
                vim-dispatch
                vim-go
                vim-jsx-typescript
                vim-lastplace
                vim-nix
                vim-sleuth #tpope/vim-sleuth
                vim-surround #tpope/vim-surround
                vim-test #janko/vim-test
                vim-vinegar
                vim-visual-multi #mg979/vim-visual-multi
                vim-vsnip
                vimTempl
                vimwiki
                vimwikiSync
              ];
              opt = [ ];
            };
            customRC = builtins.readFile ./../dotfiles/.vimrc;
          };
        }
      )
    ];

  programs.zsh.enable = true; # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
