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
    calibre
    easyeffects
    evince
    pwvucontrol
    signal-desktop-bin
    simple-scan
    # slack
    spotify
    # ventoy
    vlc
    xfce.thunar
    # xwaylandvideobridge
    # yubikey-manager

    # browser
    firefox

    # hyprland dependencies
    hyprpolkitagent
  ];
}
