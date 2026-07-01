# modules/nixos/users.nix
#
# Note: `flake.nixosModules.users` (below) is the flake-parts OUTPUT key.
# The `cthyllaxy.users` inside the module body is our own NixOS-level option
# namespace (config scope) consumed by the host modules.
{...}: {
  flake.nixosModules.users = {
    pkgs,
    config,
    lib,
    ...
  }: let
    cfg = config.cthyllaxy.users;

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
    options.cthyllaxy.users = {
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
  };
}
