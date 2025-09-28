{ config, lib, ... }:
let cfg = config.userModules.terminal.shell.fish;
in {
  options.userModules.terminal.shell = {
    fish = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "fish shell";
      };
    };
  };

  config = lib.mkIf cfg.enable { # .
    programs.fish = {
      enable = true;
      shellAliases = {
        "dotf" = "cd ~/.config/";
        "nconf" = "~/.config/nvim/";
      };
    };
  };
}
