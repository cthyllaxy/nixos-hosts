{
  services = {
    upower.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    # mount thumbdrive
    gvfs.enable = true;
    udisks2.enable = true;

    # configure keymap in X11
    xserver.xkb = {
      variant = "intl";
      layout = "us";
    };

    # Enable the OpenSSH daemon.
    openssh.enable = true;
    pcscd.enable = true;

    displayManager = {
      ly = {
        enable = true;
        settings = {
          animation = "colormix";
        };
      };
    };

    desktopManager = {
      gnome.enable = false;
    };

    # Firmware updater
    fwupd.enable = true;
  };
}
