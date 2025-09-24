{ config, lib, ... }:
let cfg = config.systemModules.audio;
in {
  options.systemModules = {
    audio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable pipewire auido";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
