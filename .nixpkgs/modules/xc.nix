{ config, pkgs, fetchFromGitHub, ... }:

let
  xc = pkgs.buildGoModule {
    pname = "xc";
    version = "v0.0.110";
    subPackages = ["cmd/xc"];
    src = pkgs.fetchFromGitHub {
      owner = "joerdav";
      repo = "xc";
      rev = "v0.0.110";
      sha256 = "0rpn2cq7hf0wi9x06bmsic8cp5v7ipkfdy1pgi0ivhqgyqabszv2";
    };
    modSha256 = "14dtguu787VR8/sYA+9WaS6xr/dB6ZcUjOzDEkFDpH4=";
  };
in
{
  environment.systemPackages = [ xc ];
}
