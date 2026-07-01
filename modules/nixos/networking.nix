# modules/nixos/networking.nix
{...}: {
  flake.nixosModules.networking = {meta, ...}: {
    networking = {
      hostName = meta.hostName;
      networkmanager.enable = true;
    };
  };
}
