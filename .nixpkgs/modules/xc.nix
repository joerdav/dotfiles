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
      sha256 = "00n4mf3rjgz93zx9l495b7h68kfi3yw7sqg85vdwvik5f9np8dcb";
    };
    vendorSha256 = "1ryb8m407rijrwlxcpkwyayjf1raxi2qw4ndpjsi12q1bjhx0y33";
  };
in
{
  environment.systemPackages = [ xc ];
}
