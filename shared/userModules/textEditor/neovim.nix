{ config, lib, pkgs, ... }:

let cfg = config.userModules.textEditor.neovim;
in {
  options.userModules.textEditor = {
    neovim = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables Neovim package and config";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      gnumake
      fzf
      fd
      ripgrep
      nodejs_24
      python3
      cargo
      rustc
      xclip
      unzip
    ];

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
