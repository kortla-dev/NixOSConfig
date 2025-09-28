{ config, lib, ... }:
let cfg = config.systemModules.display._displayManager.ly;
in {
  options.systemModules.display._displayManager = {
    ly = { enable = lib.mkEnableOption "Enable ly display manager"; };
  };

  config = lib.mkIf cfg.enable { services.displayManager.ly.enable = true; };
}
