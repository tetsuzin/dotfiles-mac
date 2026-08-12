{ pkgs, user, ... }:
{
  imports = [
    ./system.nix
    ./homebrew.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.${user} = import ../home-manager/_main.nix;
    extraSpecialArgs = { inherit user; };
  };
}
