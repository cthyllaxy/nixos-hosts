# modules/nixos/boot.nix
{...}: {
  flake.nixosModules.boot = {pkgs, ...}: {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      kernelPackages = pkgs.linuxPackages_7_0;
    };
  };
}
