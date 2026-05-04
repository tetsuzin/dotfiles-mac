{ config, user, pkgs, ... }:

let
  dotfilesDir = ../../dotfiles/HOME;
  mkLink = config.lib.file.mkOutOfStoreSymlink;
in {
  imports = [
    ./packages/packages.nix
    ./themes/themes.nix
  ];

  home.username = user;
  home.stateVersion = "26.05";
  home.homeDirectory = "/Users/${user}";

  programs.home-manager.enable = true;

  programs.mise = {
    enable = true;
    enableBashIntegration = false;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      # mise を有効化
      eval "$(${pkgs.mise}/bin/mise activate zsh)"

      # ユーザのカスタム設定を読み込む
      source ~/.zshrc_custom
    '';

    profileExtra = ''
      # ユーザのカスタム設定を読み込む
      source ~/.zsh_profile_custom
    '';
  };

}
