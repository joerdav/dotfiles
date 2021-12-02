{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "xc";
  version = "v0.0.45";

  src = fetchFromGitHub {
    owner = "joe-davidson1802";
    repo = "xc";
    rev = "v0.0.45";
    sha256 = "0k5q2f1h1w0xy2301fn450bm82kaxyv6v288sym2dzsm9s03smsa";
  };

  vendorSha256 = "1ryb8m407rijrwlxcpkwyayjf1raxi2qw4ndpjsi12q1bjhx0y33";
}
