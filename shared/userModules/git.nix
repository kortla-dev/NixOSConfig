{ config, user, lib, ... }:
let
  userInfo = user.info;
  cfg = config.userModules.git;
in {
  options.userModules = {
    git = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables Git package and config";
      };
    };
  };

  config = lib.mkIf cfg.enable {

    home.file = {
      ".ssh/${userInfo.username}.pub".text = userInfo.ssh.pubKey;

      ".ssh/allowed_signers".text = "${userInfo.email} ${userInfo.ssh.pubKey}";
    };

    programs.git = {
      enable = true;
      extraConfig = {
        user = {
          name = userInfo.name;
          email = userInfo.email;
          signingkey = "${userInfo.homeDir}/.ssh/${userInfo.username}.pub";
        };
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = "${userInfo.homeDir}/.ssh/allowed_signers";
        };
        commit.gpgsign = true;
        init.defaultBranch = "master";
      };
    };
  };
}
