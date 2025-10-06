{ config, lib, ... }:
let
  cfg = config.userModules.terminal.shell.extras.starship;

  rawFmt = ''
    $username$hostname $directory$git_branch$git_state$git_status$cmd_duration$fill$nix_shell
    $line_break$character
  '';
in {
  options.userModules.terminal.shell.extras = {
    starship = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "starship";
      };
    };
  };

  config = lib.mkIf cfg.enable { # .
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        format = builtins.replaceStrings [ "\n" "\r" ] [ "" "" ] rawFmt;

        palette = "base";

        palettes.base = {
          orange = "#f7a41d"; # #d65d0e
        };

        username = {
          style_user = "bold yellow";
          format = "[$user]($style)";
          show_always = true;
        };

        hostname = {
          style = "bold yellow";
          format = "[@$hostname]($style)";
          ssh_only = false;

        };

        directory = { style = "bold blue"; };

        git_branch = {
          style = "bold bright-black";
          format = "[$branch]($style)";
        };

        git_status = {
          style = "bold cyan";
          format =
            "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          conflicted = "​";
          untracked = "​";
          modified = "​";
          staged = "​";
          renamed = "​";
          deleted = "​";
          stashed = "≡";
        };

        git_state = {
          style = "bold bright-black";
          format =
            "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        };

        cmd_duration = {
          style = "bold yellow";
          format = "[$duration]($style)";
        };

        line_break = { disabled = false; };

        nix_shell = {
          style = "bold blue";
          # impure_msg = "[impure](bold red)";
          # pure_msg = "[pure shell](bold green)";
          # unknown_msg = "[unknown shell](bold yellow)";
          format = "[\\($name\\)]($style)";
        };

        character = {
          success_symbol = "[❯](bold red)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold green)";
        };
      };
    };
  };
}
