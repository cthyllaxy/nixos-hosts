{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.nixosModules.users;

  mkUser = username: {
    isNormalUser = true;
    description = "${username}";
    hashedPasswordFile = config.sops.secrets.${username}.path;
    extraGroups = [
      "networkmanager"
      "wheel"
      "lp"
      "scanner"
    ];
  };
in {
  options.nixosModules.users = {
    usernames = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "list of usernames to be created";
    };
  };
  config = {
    sops.secrets = builtins.listToAttrs (
      map (username: {
        name = username;
        value = {
          neededForUsers = true;
        };
      })
      cfg.usernames
    );

    users = {
      users = builtins.listToAttrs (
        map (username: {
          name = username;
          value = mkUser username;
        })
        cfg.usernames
      );

      extraGroups.docker.members = cfg.usernames;

      defaultUserShell = pkgs.zsh;
    };
  };
}
