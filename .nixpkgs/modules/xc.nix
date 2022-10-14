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
    vendorSha256 = "1ryb8m407rijrwlxcpkwyayjf1raxi2qw4ndpjsi12q1bjhx0y33";
  };
in
{
  environment.systemPackages = [ xc ];
}
