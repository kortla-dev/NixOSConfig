{ config, pkgs, ... }:
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
  home.packages =
    (import ./externalDependencies/neovim-config-deps.nix { inherit pkgs; })
    ++ (with pkgs; [
      # fonts
      nerd-fonts.fira-mono

      # util
      btop

      # langs
      zig
      luajit
    ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  home.sessionVariables = { EDITOR = "nvim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish.enable = true;

  home.file.".ssh/${config.home.username}.pub".text =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0Nwz0rlwT6JTi0Tm9N1BuIXIEokZKFVLOzqTZOuPKb engelbrecht.neill@gmail.com";
  home.file.".ssh/allowed_signers".text =
    "${user.email} ${config.home.file.".ssh/${config.home.username}.pub".text}";

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
      safe.directory = "/etc/nixos";
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 12;
      font-family = "FiraMono Nerd Font";
      font-style = "Medium";
      font-style-bold = "false";
      font-style-italic = "false";
      font-style-bold-italic = "false";
      font-synthetic-style = "false";

      theme = "Ubuntu";

      window-padding-x = 5;
      window-padding-y = 5;
      window-padding-balance = "true";

      gtk-titlebar-hide-when-maximized = "true";

      command = "${pkgs.fish.outPath}/bin/fish --login --interactive";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
  };
}
