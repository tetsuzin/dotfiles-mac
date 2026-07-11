{ config, user, pkgs, ... }:

let
  dotfilesDir = ../../dotfiles/HOME;
  mkLink = config.lib.file.mkOutOfStoreSymlink;
in {
  imports = [
    ./packages/packages.nix
    ./themes/themes.nix
  ];

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.mise = {
    enable = true;
    enableBashIntegration = false;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      # mise を有効化
      eval "$(${pkgs.mise}/bin/mise activate zsh)"

      # ユーザのカスタム設定を読み込む
      source ~/.zshrc_custom
    '';

    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # ユーザのカスタム設定を読み込む
      source ~/.zprofile_custom
    '';
  };

}
