{pkgs, ...}: {
  environment.systemPackages = with pkgs; let
    nh-update = pkgs.callPackage ../packages/nh-update {};
  in [
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
    nh-update

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
    xwayland-satellite
    # xwaylandvideobridge
    # yubikey-manager

    # browser
    firefox

    # hyprland dependencies
    hyprpolkitagent
  ];
}
