# modules/nixos/base.nix
# Base nixosModule that every host inherits from.
{self, ...}: {
  flake.nixosModules.base = {pkgs, ...}: {
    imports = [
      self.nixosModules.boot
      self.nixosModules.hardware
      self.nixosModules.localization
      self.nixosModules.networking
      self.nixosModules.nix
      self.nixosModules.programs
      self.nixosModules.security
      self.nixosModules.services
      self.nixosModules.sops
      self.nixosModules."system-packages"
      self.nixosModules.users
      self.nixosModules.virtualization
    ];

    # set zsh as default shell
    environment.shells = with pkgs; [zsh];

    # Allow unfree packages + custom packages overlay
    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [(import ../../pkgs)];

    system.autoUpgrade = {
      enable = true;
      allowReboot = false;
    };
  };
}
