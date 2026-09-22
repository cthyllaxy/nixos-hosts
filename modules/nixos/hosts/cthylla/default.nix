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

    programs = {
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
    };

    services = {
      # Disable ly display manager (Jovian uses its own session management)
      displayManager.ly.enable = lib.mkForce false;

      # Enable KDE Plasma 6 desktop for desktop mode (Switch to Desktop in Steam UI)
      desktopManager.plasma6.enable = true;
    };

    # --- XIVLauncher (XLM) secret storage in the Gamescope / Big Picture session ---
    #
    # XLM stores the FFXIV password via libsecret. It does this through the
    # bundled native `libskeychain.so`, which dlopen()s `libsecret-1.so.0` (plus
    # glib and libstdc++) at runtime. On NixOS there is no global ld cache, so a
    # non-Nix binary can only find these if they are on LD_LIBRARY_PATH.
    #
    # In Desktop mode (KDE) the Plasma session happens to export enough on the
    # path for the dlopen to succeed. In the Jovian autologin Gamescope session it
    # does not, so `libsecret-1.so.0` is "not found" and XLM falls back to the
    # misleading "no org.freedesktop.secrets provider is available" error.
    #
    # Two pieces are needed and both are provided below:
    #   1. A running Secret Service (`org.freedesktop.secrets`)  -> ksecretd unit.
    #   2. libsecret + deps reachable by XLM's loader             -> prelaunch hook.

    # 1. Secret Service provider. KWallet ships `ksecretd`, which owns the
    #    `org.freedesktop.secrets` D-Bus name, but its D-Bus autoactivation fails
    #    in the pure autostart Gamescope session, so start it explicitly. With the
    #    blank "kdewallet" password (set once via KWallet Manager) it unlocks
    #    without a prompt.
    systemd.user.services.ksecretd = {
      description = "KWallet freedesktop Secret Service bridge (org.freedesktop.secrets)";
      partOf = ["graphical-session.target"];
      wantedBy = ["graphical-session.target"];
      # ksecretd is a Qt app; run it headless so it doesn't depend on (and crash
      # without) a specific display when started early in the session.
      environment.QT_QPA_PLATFORM = "offscreen";
      serviceConfig = {
        Type = "dbus";
        BusName = "org.freedesktop.secrets";
        ExecStart = "${pkgs.kdePackages.kwallet}/bin/ksecretd";
        Restart = "on-failure";
      };
    };

    # 2. Make libsecret and its runtime deps discoverable to XLM's native
    #    `libskeychain.so`. XLM's launcher (xlm.sh) sources every file in its
    #    `prelaunch.d/` directory, so drop a hook there that prepends the needed
    #    store paths to LD_LIBRARY_PATH. The path is Nix-computed so it stays
    #    correct across rebuilds.
    systemd.user.tmpfiles.rules = let
      xlmLibPath = lib.makeLibraryPath [
        pkgs.libsecret
        pkgs.glib
        pkgs.stdenv.cc.cc.lib
      ];
      prelaunchHook = pkgs.writeText "xlm-libsecret-prelaunch.sh" ''
        # Managed by nixos-hosts (cthylla). Make libsecret reachable for XLM's
        # bundled libskeychain.so so password storage works in Gamescope sessions.
        export LD_LIBRARY_PATH="${xlmLibPath}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      '';
      xlmPrelaunchDir = "%h/.local/share/Steam/compatibilitytools.d/XLM/prelaunch.d";
    in [
      "d ${xlmPrelaunchDir} 0755 - - -"
      "L+ ${xlmPrelaunchDir}/00-nixos-libsecret.sh - - - - ${prelaunchHook}"
    ];

    # Auto-unlock KWallet under SDDM autologin. Plasma6 wires kwallet-pam into the
    # `login`/`kde` PAM services, but the autologin path only inherits `sddm`, so
    # enable it there too. With a blank wallet password this needs no login pass.
    security.pam.services.sddm.kwallet = {
      enable = true;
      # Run even though the Gamescope session isn't a standard graphical login.
      forceRun = true;
    };

    # Disable niri for this host (enabled globally)
    programs.niri.enable = lib.mkForce false;

    # Lutris and Wine dependencies for non-Steam games
    environment.systemPackages = with pkgs; [
      amdgpu_top
      heroic
      kdePackages.kwallet # Secret Service provider (org.freedesktop.secrets)
      kdePackages.kwalletmanager # GUI to set/clear the wallet password
      libsecret
      lutris
      wineWow64Packages.stagingFull # Wine with staging patches (32 & 64-bit)
      winetricks # Helper for installing Windows components
      xivlauncher
    ];

    # Enable AppImage
    programs.appimage = {
      enable = true;
    };

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
