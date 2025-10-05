{ config, lib, pkgs, user, ... }:

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

    home.activation.nvimConfigClone =
      lib.hm.dag.entryAfter [ "writeBoundry" ] ''
        logfile="${user.info.homeDir}/dotfile/nixos/buildlogs.log"

        echo "-----------------------------------------------" >> "$logfile"

        # ${pkgs.git}/bin/git --version >> "$logfile"

        if ${pkgs.git}/bin/git --version >/dev/null 2>&1; then
            if [ ! -d "${user.info.homeDir}/dotfile/nvim" ]; then
                echo "NeovimConfig: Cloning config from GitHub" >> "$logfile"

                ${pkgs.git}/bin/git clone https://github.com/kortla-dev/config.nvim ${user.info.homeDir}/dotfile/nvim

                echo "NeovimConfig: Finished cloning config" >> "$logfile"
            else
                echo "NeovimConfig: Config already exists at .config/nvim" >> "$logfile"
            fi
        else
            echo "NeovimConfig: System does not have git" >> "$logfile"
        fi
      '';
  };
}
