{ config, lib, pkgs, ... }:

{
  options.modules = {
    neovim = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enabls Neovim package and config";
      };
    };
  };

  config = lib.mkIf config.modules.neovim.enable {
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
      unzip
    ];

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };

}
