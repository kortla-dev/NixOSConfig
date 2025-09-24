{ config, lib, ... }:
let cfg = config.systemModules.display._displayManager.lightdm;
in {
  options.systemModules.display._displayManager = {
    lightdm = { enable = lib.mkEnableOption "Enable lightdm display manager"; };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.displayManager.lightdm.enable = true;
  };
}
