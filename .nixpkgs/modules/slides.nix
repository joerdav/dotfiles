{ pkgs, ... }:
let
  slides = pkgs.buildGoModule rec {
    pname = "slides";
    version = "095ea050e7ed8d82c3004449019f9288426b31c8";
    src = pkgs.fetchFromGitHub {
      owner = "maaslalani";
      repo = "slides";
      rev = "${version}";
      sha256 = "1cywqrqj199hmx532h4vn0j17ypswq2zkmv8qpxpayvjwimx4pwk";
    };
    subPackages = [ "cmd" ];

    vendorSha256 = "0y6fz9rw702mji571k0gp4kpfx7xbv7rvlnmpfjygy6lmp7wga6f";
  };
in
{
  environment.systemPackages = [ slides ];
}
