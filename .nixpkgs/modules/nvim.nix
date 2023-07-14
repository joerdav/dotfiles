{ config, lib, pkgs, ... }:

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
          jellybeans-vim
          gruvbox

          # CMP tools
          cmp-buffer
          nvim-cmp
          cmp-nvim-lsp
          cmp_luasnip
          luasnip

          fzf-lsp-nvim # FZF With LSP
          fzf-vim # FZF Tools
          markdown-preview-nvim # MKDN to browser
          nerdcommenter #preservim/nerdcommenter

          nvim-treesitter # Treesitter for highlighting 
          nvim-treesitter-playground

          nvim-web-devicons # Icons
          rust-tools-nvim # Rust tools
          #symbols-outline
          trouble-nvim # List errors and warnings in code
          vim-abolish # Mostly use for Coercion to difference casing
          vim-eunuch # Helpful vim commands for moving/renaming files
          vim-dispatch # Dispatch commands
          vim-fugitive # Vim Git Client
          vim-glsl # OpenGl plugin
          vim-grammarous # Spell check
          vim-jsx-typescript # React plugin
          vim-lastplace # Save place in file
          vim-nix # Nix helper
          vim-protobuf # Protobuf plugin
          vim-sleuth # Detect tabs or spaces
          vim-surround # Surround with ysiw
          vim-vinegar # netrw helpers
          vim-visual-multi # Multi cursor
          vim-test

          gotests-vim

          (pluginGit "nvim-lualine" "lualine.nvim" "d8c392dd75778d6258da4e7c55522e94ac389732" "s4bIwha2ZWvF5jYuIfUBcT/JKK9gcMH0vms2pOO5uKs=") # Status line
          (pluginGit "ray-x" "lsp_signature.nvim" "e65a63858771db3f086c8d904ff5f80705fd962b" "17qxn2ldvh1gas3i55vigqsz4mm7sxfl721v7lix9xs9bqgm73n1") # Function signature help
          (pluginGit "dkprice" "vim-easygrep" "d0c36a77cc63c22648e792796b1815b44164653a" "bL33/S+caNmEYGcMLNCanFZyEYUOUmSsedCVBn4tV3g=") # File searcher helper
          #(pluginGit "joerdav" "templ.vim" "2d1ca014c360a46aade54fc9b94f065f1deb501a" "kFjtnchRjlbWXySZ/8z7/Q+ZXLXOdZ3hYmdrOSK4g60=") # Templ Syntax Highlight 
          (pluginGit "jakewvincent" "mkdnflow.nvim" "ca73f55bb28a6d427003e9f7aa581c24b28afd79" "CK2KtrlP9ZI2ilMldq3F/FbiV+49jEqUbVaxXIAoO1E=") # Markdown Plugin
          (pluginGit "neovim" "nvim-lspconfig" "99596a8cabb050c6eab2c049e9acde48f42aafa4" "qU9D2bGRS6gDIxY8pgjwTVEwDTa8GXHUUQkXk9pBK/U=") # Common LSP Configs
          (pluginGit "preservim" "vimux" "616fcb4799674a7a809b14ca2dc155bb6ba25788" "6rlM+DMd95ctBHqTcgQOuEOukeUF5YOaodu87aXKnQI=") # Run commands in new split
          (pluginGit "mhartington" "formatter.nvim" "51f10c8acc610d787cad2257224cee92b40216e5" "FGc6yVHhgQqjxXWkuznr2eXQLtu+DPDZNsqNxq7PU5Y=") # Format runner
          (pluginGit "nvim-lua" "plenary.nvim" "v0.1.2" "7EsquOLB7gfN2itfGFJZYKwEXBmP0xMKEOdyyjOweHg=")
          (pluginGit "andythigpen" "nvim-coverage" "5c5ab0cc575c483bf3485b9481880b5ea4160ed4" "bmcrFiu1FWUPfhB5rzItkQozj/fR4bseK2YOPFSft8A=")
          (pluginGit "DingDean" "wgsl.vim" "fbe8f0dd179aec8525d6c93bb992e409b0e4e0ee" "BCuJkp8hhM2w6kMPoTGgeiryKO94EXTPBhKzcd8yDKM=")
          (pluginGit "williamboman" "mason.nvim" "057ac5ca159c83e302a55bd839a96ff1ea2396db" "Q3qEnt7PH3pEW1aCoausyYBppwisx8mqchZUn68i1Z4=")
          (pluginGit "williamboman" "mason-lspconfig.nvim" "90a8bbf106b85b76951a34c542058ffa807de2b1" "jUbk77uefolxJI9EaoAlxkq5tstStf4JCh0xCc9IlT8=")
          (pluginGit "WhoIsSethDaniel" "mason-tool-installer.nvim" "a6c4d7df448a78b0a05fd2065bef11ed52bee51c" "bedQamYO2m0MXJYfMyCq5WcZZLGE7kPK8wpLo5qH/aA=")
          (pluginGit "Civitasv" "cmake-tools.nvim" "c0cb2c98ed03800a1b1f7fc29d4b783aec96f530" "KT+ujjWDddkgAharow7thOhL7r4o91NQFNkKnXk3y7E=")
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
