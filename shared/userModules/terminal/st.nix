{ config, pkgs, lib, ... }:

let
  baseUrl = "https://st.suckless.org/patches/";
  stCustom = pkgs.st.override {
    conf = builtins.readFile ../../../config/st/config.def.h;
    patches = [
      (pkgs.fetchpatch {
        url = "${baseUrl}gruvbox/st-gruvbox-dark-0.8.5.diff";
        sha256 = "sha256-dOkrjXGxFgIRy4n9g2RQjd8EBAvpW4tNmkOVj4TaFGg=";
      })
      (pkgs.fetchpatch {
        url =
          "${baseUrl}autocomplete/st-0.8.5-autocomplete-20220327-230120.diff";
        sha256 = "sha256-tXilaOVz196YoFHd1kChbPYy0d5rh/h/6lQGvIDEH38=";
      })
    ];
  };

  cfg = config.userModules.terminal.st;

in {
  options.userModules.terminal = {
    st = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables patches st terminal";
      };

      package = lib.mkOption {
        type = lib.types.package;
        default = stCustom;
        defaultText = "patched st with gruvbox";
        description = "The st package to use";
      };
    };

  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkIf (cfg.package != null) [ stCustom ];
  };
}
