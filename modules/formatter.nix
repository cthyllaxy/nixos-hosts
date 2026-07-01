# modules/formatter.nix
# `nix fmt` entry point.
{...}: {
  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
