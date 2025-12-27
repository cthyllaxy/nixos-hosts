{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
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
}
