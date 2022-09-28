{ config, pkgs, ... }:

let 
  nvimGoCoverage = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-goc.lua";
    src = pkgs.fetchFromGitHub {
      owner = "rafaelsq";
      repo = "nvim-goc.lua";
      rev = "7c03112ce77b7df2b124d46c1188cc3c66d06f66";
      sha256 = "1sl3f770aw52cbrqvx96ys741qwk0lv2v39qhmn2lppsp4ymk5bn";
    };
  };
  lspSignatureNvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "lsp_signature.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ray-x";
      repo = "lsp_signature.nvim";
      rev = "f7c308e99697317ea572c6d6bafe6d4be91ee164";
      sha256 = "0s48bamqwhixlzlyn431z7k3bhp0y2mx16d36g66c9ccgrs5ifmm";
    };
  };
  symbols-outline = pkgs.vimUtils.buildVimPlugin {
    name = "symbols-outline";
    src = pkgs.fetchFromGitHub {
      owner = "simrat39";
      repo = "symbols-outline.nvim";
      rev = "a1bbef84b7c7240f88092c57732c5b8eb6f48234";
      sha256 = "0vai0p365hwjs8vzadfgx66ax6jdx6pivfzzjr5v63c83kc466hq";
    };
  };
  dap-go = pkgs.vimUtils.buildVimPlugin {
    name = "dap-go";
    src = pkgs.fetchFromGitHub {
      owner = "leoluz";
      repo = "nvim-dap-go";
      rev = "fca8bf90bf017e8ecb3a3fb8c3a3c05b60d1406d";
      sha256 = "110z65ghdrn2bgxv8961bmlpchbq6pvqia8ql29bh11qdvik1d35";
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
  vim-run-interactive = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-run-interactive";
    version = "2021-09-30";
    src = pkgs.fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-run-interactive";
      rev = "6ae33c719bdf185325c3c1836978bb4352157c82";
      sha256 = "0hhx5lvp3k9rkv290nng17fh4z8ishw0q8i23i9ynpniw8wgkahd";
    };
  };
  instant-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "instant-nvim";
    version = "2021-09-30";
    src = pkgs.fetchFromGitHub {
      owner = "jbyuki";
      repo = "instant.nvim";
      rev = "c02d72267b12130609b7ad39b76cf7f4a3bc9554";
      sha256 = "1wk43a8lnwkvfl0m2bxxgidbj4p03322xvn5j1wsl678xw1gdypc";
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
  pkgs.neovim.override {
    vimAlias = true;
    withPython3 = true;
    extraPython3Packages = (ps: with ps; [
      pynvim
    ]);
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          # lsp
          cmp-buffer
          cmp-nvim-lsp
          fzf-lsp-nvim
          nvim-cmp
          nvim-lspconfig
          lsp_signature-nvim

          coverage #ruanyl/coverage.vim
          easygrep #dkprice/vim-easygrep
          formatterNvim
          fzf-vim
          instant-nvim
          markdown-preview-nvim
          nerdcommenter #preservim/nerdcommenter
          cmp_luasnip
          luasnip
          nvim-treesitter

          nvim-web-devicons
          nvimGoCoverage
          rust-tools-nvim
          #symbols-outline
          trouble-nvim
          vim-abolish
          vim-eunuch
          vim-dispatch
          vim-fugitive
          vim-glsl
          vim-grammarous
          vim-jsx-typescript
          vim-lastplace
          vim-nix
          vim-protobuf
          vim-run-interactive
          vim-sleuth #tpope/vim-sleuth
          vim-surround #tpope/vim-surround
          vim-test #janko/vim-test
          vim-vinegar
          vim-visual-multi #mg979/vim-visual-multi
          vimTempl
        ];
        opt = [ ];
      };
      customRC = "lua require('init')";
    };
  }

