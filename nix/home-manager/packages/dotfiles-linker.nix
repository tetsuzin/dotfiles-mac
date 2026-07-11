{ pkgs, ... }:

let
  dotfiles-linker = pkgs.stdenvNoCC.mkDerivation rec {
    name = "dotfiles-linker";
    version = "0.4.0";
    src = pkgs.fetchzip {
      url = "https://github.com/guitarrapc/DotfilesLinker/releases/download/${version}/DotfilesLinker_darwin_arm64.tar.gz";
      hash = "sha256-Eo+AfhJyVKQ3GgfNMcQaMzKcYM63O4yyzLWa/EgfK74=";
    };
    installPhase = ''
      install -Dm755 DotfilesLinker $out/bin/DotfilesLinker
    '';
  };

in
{
  home.packages = [ dotfiles-linker ];
}
