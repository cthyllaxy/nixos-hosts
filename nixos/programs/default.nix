{
  imports = [./steam.nix];

  programs = {
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
    };

    niri.enable = true;

    nix-ld.enable = true;

    sway.enable = false;

    xwayland.enable = true;

    zsh.enable = true;
  };
}
