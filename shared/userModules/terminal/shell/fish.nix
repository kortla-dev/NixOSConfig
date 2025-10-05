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
      shellInit = ''
        eval (direnv hook fish)
      '';
      shellAliases = {
        "dotf" = "cd ~/dotfile/";
        "conf" = "cd ~/.config/";
        "nconf" = "cd ~/.config/nvim/";
      };
    };
  };
}
