{ config, lib, ... }:
let cfg = config.userModules.displayConfig.i3;
in {

  options.userModules.displayConfig = {
    i3 = {
      enable = lib.mkEnableOption "Enable i3 config";

      terminal = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Default terminal i3 should use";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        terminal = cfg.terminal;

        keybindings = lib.mkOptionDefault {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+d" = "exec dmenu_run";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
        };

        # bars = [{ statusCommand = "i3status"; }];
      };

      extraConfig = ''
        exec --no-startup-id bash -c "echo | dmenu_run >/dev/null"
      '';
    };
  };

}
