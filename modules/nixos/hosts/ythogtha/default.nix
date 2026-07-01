# modules/nixos/hosts/ythogtha/default.nix
{...}: {
  flake.nixosModules."hosts/ythogtha" = {...}: {
    imports = [
      ./_hardware-configuration.nix
      ./_disko-config.nix
    ];

    # my nixos modules
    nixosModules = {
      users.usernames = ["thamenato"];
      steam.enable = true;
    };

    system.stateVersion = "24.05";
  };
}
