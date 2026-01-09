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
    nh-update
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
    signal-desktop
    simple-scan
    # slack
    spotify
    # ventoy
    vlc
    xwayland-satellite
    # xwaylandvideobridge
    # yubikey-manager

    # browser
    firefox

    # hyprland dependencies
    hyprpolkitagent
  ];
}
