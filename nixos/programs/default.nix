{
  inputs,
  pkgs,
  ...
}: {
  imports = [./steam.nix];

  programs = {
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 5";
    };

    niri.enable = true;

    nix-ld.enable = true;

    river.enable = true;

    sway.enable = false;

    xwayland.enable = true;

    zsh.enable = true;
  };
}
