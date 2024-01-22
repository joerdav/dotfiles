{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, darwin, home-manager, ... }:
    let
      getPkgsForSystem = system:
        import nixpkgs {
		configs.allowUnfree = true;
          overlays = [
            (self: super: {
            })
          ];
        };
    in
    {
      darwinConfigurations = {
        joe-mac = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          pkgs = getPkgsForSystem "x86_64-darwin";
          modules = [ ./.nixpkgs/darwin-configuration.nix ];
        };
      };
    };
}
