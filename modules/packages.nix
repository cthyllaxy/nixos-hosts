# modules/packages.nix
# Expose overlay packages as flake outputs (pkgs carries the overlay via
# modules/pkgs.nix), enabling `nix build .#curseforge` and `nix flake show`.
{...}: {
  perSystem = {pkgs, ...}: {
    packages.curseforge = pkgs.curseforge;
  };
}
