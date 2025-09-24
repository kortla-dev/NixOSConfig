{ config, lib, ... }:
let
  cfg = config.systemModules.display;
  allowedDm = [ "none" "lightdm" ];
  allowedWm = [ "none" "xfce4" ];
in {

  imports = [ # .
    ./displayManager
    ./managers
  ];

  options.systemModules.display = {
    enable = lib.mkEnableOption "Enable graphical module";

    displayManager = lib.mkOption {
      type = lib.types.enum allowedDm;
      default = "none";
      description = "The window manager or desktop environment to use.";
    };

    manager = lib.mkOption {
      type = lib.types.enum allowedWm;
      default = "none";
      description = "The display manager to use.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [{
      assertion = (cfg.manager == "none" && cfg.displayManager == "none")
        || (cfg.manager != "none" && cfg.displayManager != "none");
      message =
        "You must set *both* a manager and a displayManager — or *neither*.";
    }];

    systemModules.display._displayManager.${cfg.displayManager}.enable = true;
    systemModules.display._manager.${cfg.manager}.enable = true;
  };
}
