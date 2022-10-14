{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
  ];
  system.stateVersion = 4;
}
