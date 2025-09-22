{ config, lib, ... }:

{
  options.userModules = {
    nightlight.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables Redshift package and config";
    };
  };

  config = lib.mkIf config.userModules.nightlight.enable {
    services.redshift = {
      enable = true;
      temperature = {
        day = 3500;
        night = 3500;
      };
      provider = "manual";
      latitude = "0";
      longitude = "0";
    };
  };
}
