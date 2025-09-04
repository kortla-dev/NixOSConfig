{ config, lib, ... }:
let
  user = {
    name = "Neill Engelbrecht";
    email = "engelbrecht.neill@gmail.com";
  };
in {
  options.modules = {
    git = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables Git package and config";
      };
    };
  };

  config = lib.mkIf config.modules.git.enable {

    home.file = {
      ".ssh/${config.home.username}.pub".text =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0Nwz0rlwT6JTi0Tm9N1BuIXIEokZKFVLOzqTZOuPKb";

      ".ssh/allowed_signers".text = "${user.email} ${
          config.home.file.".ssh/${config.home.username}.pub".text
        }";
    };

    programs.git = {
      enable = true;
      extraConfig = {
        user = {
          name = user.name;
          email = user.email;
          signingkey =
            "${config.home.homeDirectory}/.ssh/${config.home.username}.pub";
        };
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile =
            "${config.home.homeDirectory}/.ssh/allowed_signers";
        };
        commit.gpgsign = true;
      };
    };
  };
}
