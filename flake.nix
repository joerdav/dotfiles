{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    dynamotableviz = {
      url = "github:a-h/dynamotableviz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xc = {
      url = "github:joerdav/xc";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    goreleaser = {
      url = "github:a-h/nix-goreleaser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil = {
      url = "github:oxalica/nil";
    };
  };

  outputs = { nixpkgs, darwin, home-manager, dynamotableviz, xc, goreleaser, nil, ... }:
    let
      getPkgsForSystem = system:
        import nixpkgs {
		configs.allowUnfree = true;
          overlays = [
            (self: super: {
              dynamotableviz = dynamotableviz.packages.${system}.dynamotableviz;
              xc = xc.packages.${system}.xc;
              goreleaser = goreleaser.packages.${system}.goreleaser;
              nil = nil.packages.${system}.nil;
            })
          ];
        };
    in
    {
      darwinConfigurations = {
        joe-mac = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = getPkgsForSystem "aarch64-darwin";
          modules = [ ./.nixpkgs/darwin-configuration.nix ];
        };
      };
    };
}
