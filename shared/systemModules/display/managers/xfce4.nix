{ config, lib, ... }:
let cfg = config.systemModules.display._manager.xfce4;
in {

  options.systemModules.display._manager = {
    xfce4 = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable xfce4";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Enable the XFCE Desktop Environment.
      # displayManager.lightdm.enable = true;
      desktopManager.xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
      windowManager.i3.enable = true;
    };
    services.displayManager.defaultSession = "xfce";
  };
}
