# modules/nixos/hosts/kassogtha/default.nix
{
  self,
  lib,
  ...
}: {
  flake.nixosModules."hosts/kassogtha" = {pkgs, ...}: {
    imports = [
      ./_hardware-configuration.nix
      ./_disko-config.nix
      self.nixosModules."hardware/amd-gpu"
    ];

    hardware.system76.enableAll = true;

    environment.systemPackages = with pkgs; [
      wowup-cf
      system76-firmware
    ];

    # custom modules
    cthyllaxy = {
      users.usernames = ["thamenato" "nmeusling"];
      steam.enable = true;
    };

    services = {
      desktopManager = {
        gnome.enable = lib.mkForce true;
      };
    };

    system.stateVersion = "23.11";
  };
}
