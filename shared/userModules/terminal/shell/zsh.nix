{ config, pkgs, lib, ... }:
let cfg = config.userModules.terminal.shell.zsh;
in {
  options.userModules.terminal.shell = {
    zsh = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "zsh shell";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
    };

    # config.environment.pathsToLink = [ "/share/zsh" ];

  };
}
