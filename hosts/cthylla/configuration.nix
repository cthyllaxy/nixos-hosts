{
  inputs,
  lib,
  pkgs,
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

  # NOTE: SDDM is intentionally disabled - it conflicts with jovian.steam.autoStart
  # Jovian handles session switching internally via steamos-manager

  # Enable KDE Plasma 6 desktop (provides session files for desktopSession = "plasma")
  services.desktopManager.plasma6.enable = true;

  # Disable niri for this host (enabled globally)
  programs.niri.enable = lib.mkForce false;

  # Desktop Steam (available when in Plasma desktop mode)
  programs.steam.enable = true;

  # Lutris and Wine dependencies for non-Steam games
  environment.systemPackages = with pkgs; [
    lutris
    wineWow64Packages.stagingFull # Wine with staging patches (32 & 64-bit)
    winetricks # Helper for installing Windows components
  ];

  # Ensure /steam directory structure for Steam game library
  # Steam will recognize this structure when you add it via Settings > Storage
  systemd.tmpfiles.rules = [
    "d /steam 0755 nmeusling users -"
    "d /steam/steamapps 0755 nmeusling users -"
    "d /steam/steamapps/common 0755 nmeusling users -"
    "d /steam/steamapps/downloading 0755 nmeusling users -"
    "d /steam/steamapps/temp 0755 nmeusling users -"
  ];

  # User configuration
  nixosModules.users.usernames = ["nmeusling"];

  system.stateVersion = "25.05";
}
