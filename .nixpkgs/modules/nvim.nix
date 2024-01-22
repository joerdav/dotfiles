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
