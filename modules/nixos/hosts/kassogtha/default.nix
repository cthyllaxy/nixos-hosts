# modules/nixos/hosts/kassogtha/default.nix
{self, ...}: {
  flake.nixosModules."hosts/kassogtha" = {pkgs, ...}: {
    imports = [
      ./_hardware-configuration.nix
      ./_disko-config.nix
      self.nixosModules."hardware/amd-gpu"
    ];

    hardware.system76.enableAll = true;

    environment.systemPackages = with pkgs; [
      curseforge
      system76-firmware
    ];

    # custom modules
    cthyllaxy = {
      users.usernames = ["thamenato" "nmeusling"];
      steam.enable = true;
    };

    system.stateVersion = "23.11";
  };
}
