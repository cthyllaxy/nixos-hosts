# modules/nixos/hosts/kassogtha/default.nix
{...}: {
  flake.nixosModules."hosts/kassogtha" = {pkgs, ...}: {
    imports = [
      ./_hardware-configuration.nix
      ./_disko-config.nix
    ];

    hardware.system76.enableAll = true;

    environment.systemPackages = with pkgs; [
      system76-firmware
    ];

    services.xserver.videoDrivers = ["amdgpu"];

    # nixos modules
    nixosModules = {
      users.usernames = ["thamenato" "nmeusling"];
      steam.enable = true;
    };

    system.stateVersion = "23.11";
  };
}
