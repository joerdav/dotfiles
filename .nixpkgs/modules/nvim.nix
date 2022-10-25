{ config, pkgs, ... }:

let
  pluginGit = owner: repo: ref: sha: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${repo}";
    version = ref;
    src = pkgs.fetchFromGitHub {
      owner = owner;
      repo = repo;
      rev = ref;
      sha256 = sha;
    };
  };
  nvim = pkgs.neovim.override {
    vimAlias = true;
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          (pluginGit "rafaelsq" "nvim-goc.lua" "7d23d820feeb30c6346b8a4f159466ee77e855fd" "lh+U0NtLYLmuCQIwStrJTCo32i8OuplGmUCzSnSJOa0=")
          (pluginGit "ray-x" "lsp_signature.nvim" "f7c308e99697317ea572c6d6bafe6d4be91ee164" "tbpYdH6MJWbMM6OZ0Kvw4MI15vlhEOvppz1CjqtaiGg=")
          (pluginGit "dkprice" "vim-easygrep" "d0c36a77cc63c22648e792796b1815b44164653a" "bL33/S+caNmEYGcMLNCanFZyEYUOUmSsedCVBn4tV3g=")
          (pluginGit "mhartington" "formatter.nvim" "51f10c8acc610d787cad2257224cee92b40216e5" "FGc6yVHhgQqjxXWkuznr2eXQLtu+DPDZNsqNxq7PU5Y=")
          (pluginGit "joerdav" "templ.vim" "2d1ca014c360a46aade54fc9b94f065f1deb501a" "kFjtnchRjlbWXySZ/8z7/Q+ZXLXOdZ3hYmdrOSK4g60=")
          (pluginGit "jakewvincent" "mkdnflow.nvim" "ca73f55bb28a6d427003e9f7aa581c24b28afd79" "CK2KtrlP9ZI2ilMldq3F/FbiV+49jEqUbVaxXIAoO1E=")

          cmp-buffer
          cmp-nvim-lsp
          fzf-lsp-nvim
          nvim-cmp
          nvim-lspconfig

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
        ];
        opt = [
        ];
      };
      customRC = ''
        lua << EOF
        require("init-nix")
        EOF
      '';
    };
  };
in
{
  environment.systemPackages = [ nvim ];
}
