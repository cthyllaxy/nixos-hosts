{
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    inputs.jovian.nixosModules.default
  ];

  # Jovian NixOS - Steam Deck UI experience
  jovian.steam = {
    enable = true;
    autoStart = true;
    user = "nmeusling";
    desktopSession = "plasma";
  };

  # Disable ly display manager (Jovian uses its own session management)
  services.displayManager.ly.enable = lib.mkForce false;

  # Enable SDDM (required for Plasma session registration)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Enable KDE Plasma 6 desktop (minimal)
  services.desktopManager.plasma6.enable = true;

  # Disable niri for this host (enabled globally)
  programs.niri.enable = lib.mkForce false;

  # Desktop Steam (available when in Plasma desktop mode)
  programs.steam.enable = true;

  # Ensure /steam is owned by nmeusling
  systemd.tmpfiles.rules = [
    "d /steam 0755 nmeusling users -"
  ];

  # User configuration
  nixosModules.users.usernames = ["nmeusling"];

  system.stateVersion = "25.05";
}
