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
    gscan2pdf
    pwvucontrol
    signal-desktop
    simple-scan
    spotify
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
