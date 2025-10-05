{ config, pkgs, lib, user, ... }:
let
  cfg = config.systemModules.gaming.steam;
  userInfo = user.info;

in {
  options.systemModules.gaming = {
    steam = { enable = lib.mkEnableOption "Enable steam"; };
  };

  config = lib.mkIf cfg.enable {

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # services.xserver.videoDrivers = [ "nvidia" ];
    # hardware.nvidia.modesetting.enable = true;

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [ # .
      mangohud
      protonup
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "${userInfo.homeDir}/.steam/root/compatibilitytools.d";
    };
  };
}
