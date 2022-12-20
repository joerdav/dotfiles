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
  nvim-treesitter-playground = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-treesitter-playground";
    version = "e6a0bfaf9b5e36e3a327a1ae9a44a989eae472cf";

    src = pkgs.fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "playground";
      rev = "e6a0bfaf9b5e36e3a327a1ae9a44a989eae472cf";
      sha256 = "wst6YwtTJbR65+jijSSgsS9Isv1/vO9uAjuoUg6tVQc=";
    };
  };

  nvim = pkgs.neovim.override {
    vimAlias = true;
    configure = {
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          (pluginGit "rafaelsq" "nvim-goc.lua" "7d23d820feeb30c6346b8a4f159466ee77e855fd" "lh+U0NtLYLmuCQIwStrJTCo32i8OuplGmUCzSnSJOa0=")
          (pluginGit "ray-x" "lsp_signature.nvim" "e65a63858771db3f086c8d904ff5f80705fd962b" "17qxn2ldvh1gas3i55vigqsz4mm7sxfl721v7lix9xs9bqgm73n1")
          (pluginGit "dkprice" "vim-easygrep" "d0c36a77cc63c22648e792796b1815b44164653a" "bL33/S+caNmEYGcMLNCanFZyEYUOUmSsedCVBn4tV3g=")
          (pluginGit "mhartington" "formatter.nvim" "51f10c8acc610d787cad2257224cee92b40216e5" "FGc6yVHhgQqjxXWkuznr2eXQLtu+DPDZNsqNxq7PU5Y=")
          (pluginGit "joerdav" "templ.vim" "2d1ca014c360a46aade54fc9b94f065f1deb501a" "kFjtnchRjlbWXySZ/8z7/Q+ZXLXOdZ3hYmdrOSK4g60=")
          (pluginGit "jakewvincent" "mkdnflow.nvim" "ca73f55bb28a6d427003e9f7aa581c24b28afd79" "CK2KtrlP9ZI2ilMldq3F/FbiV+49jEqUbVaxXIAoO1E=")
          (pluginGit "Mofiqul" "dracula" "55f24e76a978c73c63d22951b0700823f21253b7" "YwcbSj+121/QaEIAqqG4EvCpCYj3VzgCE8Ndl1ABbFI=")
          (pluginGit "neovim" "nvim-lspconfig" "99596a8cabb050c6eab2c049e9acde48f42aafa4" "qU9D2bGRS6gDIxY8pgjwTVEwDTa8GXHUUQkXk9pBK/U=")
          (pluginGit "preservim" "vimux" "616fcb4799674a7a809b14ca2dc155bb6ba25788" "6rlM+DMd95ctBHqTcgQOuEOukeUF5YOaodu87aXKnQI=")

          cmp-buffer
          nvim-cmp
          cmp-nvim-lsp
          cmp_luasnip
          luasnip

          fzf-lsp-nvim
          fzf-vim
          markdown-preview-nvim
          nerdcommenter #preservim/nerdcommenter
          nvim-treesitter
          nvim-treesitter-playground

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
