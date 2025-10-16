{pkgs, ...}: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./localization.nix
    ./networking.nix
    ./nix.nix
    ./programs
    ./security.nix
    ./services.nix
    ./sops.nix
    ./system-packages.nix
    ./user.nix
    ./virtualization.nix
  ];

  # set zsh as default shell
  environment.shells = with pkgs; [zsh];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };
}
