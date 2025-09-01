{ config, pkgs, ... }:

{
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

  programs.bash = {
    enable = true;
    initExtra = ''
      function git_branch() {
        git branch --show-current 2>/dev/null
      }
      PS1='\n\[\e[48;5;27m\]<\s>\[\e[38;5;220;48;5;239m\][\u@\h\[\e[22;39m\] \[\e[38;5;220;1m\]\W]\[\e[48;5;23m\]$(git_branch):\[\e[0m\] '
    '';
  };

  programs.git = {
    enable = true;
    userName = "Neill Engelbrecht";
    userEmail = "engelbrecht.neill@gmail.com";
    signing = {
      format = "ssh";
      key = "~/.ssh/kortla.pub";
      signByDefault = true;
    };
    extraConfig = {
      user = {
        name = "Neill Engelbrecht";
        email = "engelbrecht.neill@gmail.com";
      };
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
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
  };
}
