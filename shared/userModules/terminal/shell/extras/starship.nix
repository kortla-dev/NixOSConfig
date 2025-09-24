{ config, lib, ... }:
let
  cfg = config.userModules.terminal.shell.extras.starship;

  rawFmt = ''
    $username$hostname $directory$git_branch$git_state$git_status$cmd_duration
    $line_break
    $zig$c$lua$rust$cpp$java$php$character
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
          style = "bold yellow";
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
          sytle = "bold bright-black";
          format =
            "\\([$state( $progress_current/$progress_total)]($style)\\) ";
        };

        cmd_duration = {
          style = "bold yellow";
          format = "[$duration]($style)";
        };

        c = {
          symbol = " ";
          style = "bold orange";
          format = "[[$symbol($version)](fg:black bg:blue)]($style)";
        };

        cpp = {
          symbol = " ";
          style = "bold orange";
          format = "[[$symbol($version)](fg:black bg:blue)]($style)";
        };

        rust = {
          symbol = " ";
          style = "bold orange";
          format = "[[$symbol($version)](fg:black bg:blue)]($style)";
        };

        php = {
          symbol = " ";
          style = "bold orange";
          format = "[[$symbol($version)](fg:black bg:blue)]($style)";
        };

        java = {
          symbol = " ";
          style = "bold orange";
          format = "[[$symbol($version)](fg:black bg:blue)]($style)";
        };

        lua = {
          symbol = " ";
          style = "bold orange";
          format = "[$symbol($version)]($style)";
        };

        zig = {
          symbol = " ";
          style = "bold orange";
          format = "[$symbol($version)]($style)";
        };

        line_break = { disabled = false; };

        character = {
          success_symbol = "[❯](bold red)";
          error_symbol = "[❯](bold red)";
          vimcmd_symbol = "[❮](bold green)";
        };
      };
    };
  };
}
