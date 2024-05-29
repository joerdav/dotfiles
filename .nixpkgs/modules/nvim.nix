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
