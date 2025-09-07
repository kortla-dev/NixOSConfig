{ config, lib, pkgs, ... }:

{
  options.modules = {
    terminal = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables Ghostty package and config";
      };
    };
  };

  config = lib.mkIf config.modules.terminal.enable {

    programs.fish = {
      enable = true;
      # plugins = [{
      #   name = "tide";
      #   src = pkgs.fishPlugins.tide.src;
      # }];
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

        cursor-color = "#FFFFFF";
        cursor-text = "#000000";

        foreground = "#F5F5DC";

        theme = "Solarized Dark Higher Contrast";
        # theme = "Ubuntu";

        window-padding-x = 5;
        window-padding-y = 5;
        window-padding-balance = "true";

        gtk-titlebar-hide-when-maximized = "true";

        command = "fish --login --interactive";
      };
    };
  };
}
