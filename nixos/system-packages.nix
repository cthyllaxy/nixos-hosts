{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # tools/cli
    # bitwarden-cli
    curl
    dig
    gnupg
    htop
    lf
    neovim
    nh
    pulseaudio
    unixtools.xxd
    wget

    # programming
    git

    # terminal
    ghostty
    mako
    networkmanagerapplet
    rofi

    # apps
    arandr
    # calibre
    easyeffects
    evince
    gnome-disk-utility
    # google-chrome
    gscan2pdf
    pwvucontrol
    signal-desktop
    simple-scan
    spotify
    thunar
    vlc
    xwayland-satellite
    # slack
    # ventoy

    # browser
    firefox

    # hyprland dependencies
    hyprpolkitagent
  ];
}
