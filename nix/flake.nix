{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs = {
    self, 
    nix-darwin,
    nixpkgs, 
    home-manager,
    nix-homebrew
  }:

  let
    hostName = "shion";
    system = "aarch64-darwin";
    user = "tetsuzin";
  in
  {
    darwinConfigurations."${hostName}" = nix-darwin.lib.darwinSystem {
      system = system;
      modules = [
        ./nix-darwin/_main.nix
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
      ];
      specialArgs = { inherit user; };
    };
  };
}
