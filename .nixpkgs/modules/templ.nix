{ pkgs, ... }:

let
  templ = pkgs.buildGoModule {
    pname = "templ";
    version = "v0.2.186";
    subPackages = ["cmd/templ"];

    src = pkgs.fetchFromGitHub {
      owner = "a-h";
      repo = "templ";
      rev = "v0.2.196";
      sha256 = "1m865kbpbpw7w64awh1b915xzqw4hz5mj46jdf7jaf3zvqrm30d7";
    };

    modSha256 = "00i5g8ab9ndlh9pq1q7c6md7xmzpvj7nq30b45ra2c5gf2cymrar";
  };
in
{
  environment.systemPackages = [ templ ];
}
