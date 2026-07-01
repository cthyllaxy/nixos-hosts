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

    # Jovian NixOS - Steam Deck UI experience
    jovian = {
      steam = {
        enable = true;
        # A/B test: boot into the Plasma desktop instead of Steam Game Mode
        # (nested gamescope) so Diablo 4 / Battle.net can be tested outside the
        # SteamOS compositor. Re-enable once Proton is ruled in/out.
        autoStart = false;
        user = "nmeusling";
        # desktopSession has no effect while autoStart = false; SDDM + plasma6
        # already land on Plasma. Re-add `desktopSession = "plasma";` if
        # autoStart is turned back on.
      };

      hardware.has.amd.gpu = true;
    };

    # Disable ly display manager (Jovian uses its own session management)
    services.displayManager.ly.enable = lib.mkForce false;

    # With autoStart = false there is no Jovian session manager, so use SDDM to
    # reach the Plasma desktop. SDDM also populates the session data that
    # Jovian's `desktopSession` check requires. (SDDM only conflicts with
    # jovian.steam.autoStart = true.)
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Enable KDE Plasma 6 desktop (provides session files for desktopSession = "plasma")
    services.desktopManager.plasma6.enable = true;

    # Disable niri for this host (enabled globally)
    programs.niri.enable = lib.mkForce false;

    # Desktop Steam via the shared module: brings proton-ge-bin + gamemode
    # (matches zoth-ommog). gamescope is left off so the desktop-mode test
    # doesn't stack a second gamescope session on top of Jovian's.
    cthyllaxy.steam = {
      enable = true;
      gamescope = false;
    };

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
