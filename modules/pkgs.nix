# modules/pkgs.nix
# Per-system pkgs carrying the custom overlay + allowUnfree, used by the devShell.
# (nixosConfigurations get the overlay/allowUnfree via modules/nixos/base.nix.)
{inputs, ...}: {
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [(import ../pkgs)];
    };
  };
}
