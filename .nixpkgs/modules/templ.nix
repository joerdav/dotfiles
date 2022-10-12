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
      sha256 = "1qqpczj0yjr81d3qrxnfsikzr47bnb0icj135mfalkdlvqsq0wvn";
    };

    vendorSha256 = "00i5g8ab9ndlh9pq1q7c6md7xmzpvj7nq30b45ra2c5gf2cymrar";
  };
in
{
  environment.systemPackages = [ templ ];
}
