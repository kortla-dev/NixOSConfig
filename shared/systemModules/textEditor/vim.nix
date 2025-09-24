{ config, pkgs, lib, ... }:
let cfg = config.systemModules.textEditor.vim;
in {
  options.systemModules.textEditor = {
    vim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enables Git package and config";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        ((vim_configurable.override { }).customize {
          name = "vim";
          # Install plugins for example for syntax highlighting of nix files
          vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
            start = [ vim-nix vim-lastplace ];
            opt = [ ];
          };
          vimrcConfig.customRC = ''
            syntax on
            set number
            set relativenumber
            set backspace=indent,eol,start
            set tabstop=2
            set shiftwidth=2
            set expandtab
            set autoindent
            set smartindent
            set nowrap
            set clipboard=unnamedplus
          '';
        })
      ];
  };
}
