{ config, pkgs, ... }:

let
  nvimGoCoverage = pkgs.vimUtils.buildVimPlugin {
    pname = "nvim-goc.lua";
    version = "2022-10-04";
    src = pkgs.fetchFromGitHub {
      owner = "rafaelsq";
      repo = "nvim-goc.lua";
      rev = "7c03112ce77b7df2b124d46c1188cc3c66d06f66";
      sha256 = "1sl3f770aw52cbrqvx96ys741qwk0lv2v39qhmn2lppsp4ymk5bn";
    };
  };
  lspSignatureNvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "lsp_signature.nvim";
    version = "2022-10-04";
    src = pkgs.fetchFromGitHub {
      owner = "ray-x";
      repo = "lsp_signature.nvim";
      rev = "f7c308e99697317ea572c6d6bafe6d4be91ee164";
      sha256 = "0s48bamqwhixlzlyn431z7k3bhp0y2mx16d36g66c9ccgrs5ifmm";
    };
  };
  symbols-outline = pkgs.vimUtils.buildVimPlugin {
    pname = "symbols-outline";
    version = "2022-10-04";
    src = pkgs.fetchFromGitHub {
      owner = "simrat39";
      repo = "symbols-outline.nvim";
      rev = "a1bbef84b7c7240f88092c57732c5b8eb6f48234";
      sha256 = "0vai0p365hwjs8vzadfgx66ax6jdx6pivfzzjr5v63c83kc466hq";
    };
  };
  easygrep = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-easygrep";
    version = "2022-10-04";
    src = pkgs.fetchFromGitHub {
      owner = "dkprice";
      repo = "vim-easygrep";
      rev = "d0c36a77cc63c22648e792796b1815b44164653a";
      sha256 = "0y2p5mz0d5fhg6n68lhfhl8p4mlwkb82q337c22djs4w5zyzggbc";
    };
  };
  formatterNvim = pkgs.vimUtils.buildVimPlugin {
    pname = "formatter.nvim";
    version = "2022-10-04";
    src = pkgs.fetchFromGitHub {
      owner = "mhartington";
      repo = "formatter.nvim";
      rev = "51f10c8acc610d787cad2257224cee92b40216e5";
      sha256 = "15jkrypcd3fa6vcz035yvcpd1rfrxcwvp93mqnihm0g1a74klrql";
    };
  };
  vimTempl = pkgs.vimUtils.buildVimPlugin {
    pname = "templ.vim";
    version = "2022-10-04";
    src = pkgs.fetchFromGitHub {
      owner = "Joe-Davidson1802";
      repo = "templ.vim";
      rev = "2d1ca014c360a46aade54fc9b94f065f1deb501a";
      sha256 = "1bc3p0i3jsv7cbhrsxffnmf9j3zxzg6gz694bzb5d3jir2fysn4h";
    };
  };

  nvim = pkgs.neovim.override {
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

          easygrep #dkprice/vim-easygrep
          formatterNvim
          fzf-vim
          markdown-preview-nvim
          nerdcommenter #preservim/nerdcommenter
          cmp_luasnip
          luasnip
          nvim-treesitter

          nvim-web-devicons
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
  };
in
{
  environment.systemPackages = [ nvim ];
}
