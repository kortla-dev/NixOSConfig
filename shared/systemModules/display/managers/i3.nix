{ config, pkgs, lib, ... }:
let cfg = config.systemModules.display._manager.i3;
in {

  options.systemModules.display._manager = {
    i3 = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable i3";
      };
    };
  };

  config = lib.mkIf cfg.enable {

    # environment.variables = {
    #   QT_QPA_PLATFORMTHEME = "gtk3";
    #   QT_STYLE_OVERRIDE = "Adwaita-Dark";
    # };

    services.xserver = {
      # Enable the X11 windowing system.
      enable = true;

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [ dmenu i3status nnn ];
      };
    };
  };

}
