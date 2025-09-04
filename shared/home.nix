{ config, pkgs, inputs, ... }:
let
  user = {
    name = "Neill Engelbrecht";
    email = "engelbrecht.neill@gmail.com";
  };
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kortla";
  home.homeDirectory = "/home/kortla";

  imports = [ ./modules ];

  modules.neovim.enable = true;
  modules.terminal.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # fonts
    nerd-fonts.fira-mono

    # util
    btop

    # langs
    zig
    luajit

    # other
    vlc
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  home.sessionVariables = { EDITOR = "nvim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    ".ssh/${config.home.username}.pub".text =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0Nwz0rlwT6JTi0Tm9N1BuIXIEokZKFVLOzqTZOuPKb";

    ".ssh/allowed_signers".text = "${user.email} ${
        config.home.file.".ssh/${config.home.username}.pub".text
      }";
  };

  programs.git = {
    enable = true;
    extraConfig = {
      user = {
        name = user.name;
        email = user.email;
        signingkey =
          "${config.home.homeDirectory}/.ssh/${config.home.username}.pub";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile =
          "${config.home.homeDirectory}/.ssh/allowed_signers";
      };
      commit.gpgsign = true;
    };
  };
}
