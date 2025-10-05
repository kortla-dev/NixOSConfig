{ pkgs, user, userModules, ... }:
let userInfo = user.info;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userInfo.username;
  home.homeDirectory = userInfo.homeDir;
  home.stateVersion = "25.05"; # Please read the comment before changing.
  home.file = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.fira-mono
    # util
    btop
    # other
    kdePackages.falkon

    keepassxc
  ];

  # TODO: make module for direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.sessionVariables = { EDITOR = "nvim"; };

  imports = [ ./userModules ];

  inherit userModules;
}
