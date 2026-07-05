# CurseForge - Mod manager for Minecraft, WoW, and other games
#
# To update:
#   1. Run: nix-prefetch-url https://curseforge.overwolf.com/downloads/curseforge-latest-linux.AppImage
#   2. Replace the sha256 below with the new hash
#
{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
}: let
  pname = "curseforge";
  version = "latest";

  src = fetchurl {
    url = "https://curseforge.overwolf.com/downloads/curseforge-latest-linux.AppImage";
    sha256 = "0idncmn820pnnpavk2rnvwlgppk1ilnryjm7y7q8n4agcgsa8qzl";
  };

  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    desktopName = "CurseForge";
    genericName = "Mod Manager";
    comment = "Download and manage mods for Minecraft, WoW, and other games";
    categories = ["Game" "Utility"];
    startupWMClass = "CurseForge";
    mimeTypes = [
      "x-scheme-handler/curseforge"
      "x-scheme-handler/cfauth"
      "x-scheme-handler/curseforge-checkout"
    ];
  };

  appimageContents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      # Install desktop entry
      mkdir -p $out/share/applications
      cp ${desktopItem}/share/applications/* $out/share/applications/

      # Install icons at multiple resolutions
      for size in 16 32 48 128 256 512 1024; do
        install -Dm644 ${appimageContents}/usr/share/icons/hicolor/''${size}x''${size}/apps/curseforge.png \
          $out/share/icons/hicolor/''${size}x''${size}/apps/${pname}.png
      done
    '';

    meta = with lib; {
      description = "CurseForge - Mod manager for Minecraft, WoW, and other games";
      homepage = "https://www.curseforge.com/";
      license = licenses.unfree;
      platforms = ["x86_64-linux"];
      mainProgram = "curseforge";
    };
  }
