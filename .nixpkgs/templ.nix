{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "templ";
  version = "v0.0.153";

  src = fetchFromGitHub {
    owner = "a-h";
    repo = "templ";
    rev = "v0.0.153";
    sha256 = "1qqpczj0yjr81d3qrxnfsikzr47bnb0icj135mfalkdlvqsq0wvn";
  };

  vendorSha256 = "00i5g8ab9ndlh9pq1q7c6md7xmzpvj7nq30b45ra2c5gf2cymrar";
}
