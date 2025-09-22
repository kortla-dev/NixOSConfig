{ config, pkgs, ... }:
let user-info = config.user.info;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user-info.username;
  home.homeDirectory = "/home/${user-info.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # fonts
    nerd-fonts.fira-mono

    # util
    btop

    # other
    kdePackages.falkon
  ];

  home.sessionVariables = {
    SHELL = "fish --login --interactive";
    EDITOR = "nvim";
  };

  imports = [ ./userModules ];

  modules = {
    git.enable = true;
    terminal.enable = true;
    neovim.enable = true;
    nightlight.enable = true;
    # st.enable = true;
  };

}
