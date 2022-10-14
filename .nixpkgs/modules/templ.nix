{ pkgs, lib, ... }:

let
  templ = pkgs.buildGoModule {
    pname = "templ";
    version = "v0.2.186";
    subPackages = ["cmd/templ"];

    src = pkgs.fetchFromGitHub {
      owner = "a-h";
      repo = "templ";
      rev = "v0.2.186";
      sha256 = "1m865kbpbpw7w64awh1b915xzqw4hz5mj46jdf7jaf3zvqrm30d7";
    };

    vendorSha256 = lib.fakeSha256;
  };
in
{
  environment.systemPackages = [ templ ];
}