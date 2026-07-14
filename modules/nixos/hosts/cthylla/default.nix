# modules/nixos/hosts/cthylla/default.nix
{self, ...}: {
  flake.nixosModules."hosts/cthylla" = {
    inputs,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      ./_hardware-configuration.nix
      ./_disko-config.nix
      inputs.jovian.nixosModules.default
      self.nixosModules."hardware/amd-gpu"
    ];

    # Jovian NixOS - Steam Deck UI experience for desktop gaming PC
    jovian = {
      steam = {
        enable = true;
        autoStart = true;
        user = "nmeusling";
        desktopSession = "plasma";
      };

      # Explicitly disable Steam Deck hardware-specific configs
      devices.steamdeck.enable = false;

      hardware.has.amd.gpu = true;
    };

    # Disable ly display manager (Jovian uses its own session management)
    services.displayManager.ly.enable = lib.mkForce false;

    # Enable KDE Plasma 6 desktop for desktop mode (Switch to Desktop in Steam UI)
    services.desktopManager.plasma6.enable = true;

    # Disable niri for this host (enabled globally)
    programs.niri.enable = lib.mkForce false;

    # Lutris and Wine dependencies for non-Steam games
    environment.systemPackages = with pkgs; [
      amdgpu_top
      curseforge
      heroic
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
    cthyllaxy.users.usernames = ["nmeusling"];

    system.stateVersion = "25.05";
  };
}
