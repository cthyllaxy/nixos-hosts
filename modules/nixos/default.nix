# modules/nixos/default.nix
# Defines all nixosConfigurations.
{
  self,
  inputs,
  ...
}: let
  mkHost = {
    hostName,
    user ? "thamenato",
  }:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
        meta = {
          inherit hostName user;
        };
      };

      modules = [
        inputs.auto-cpufreq.nixosModules.default
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
        inputs.determinate.nixosModules.default

        # Base configuration (shared by all hosts)
        self.nixosModules.base

        # Host-specific configuration
        self.nixosModules."hosts/${hostName}"
      ];
    };
in {
  flake.nixosConfigurations = {
    kassogtha = mkHost {hostName = "kassogtha";};
    zoth-ommog = mkHost {hostName = "zoth-ommog";};
    ythogtha = mkHost {hostName = "ythogtha";};
    cthylla = mkHost {hostName = "cthylla";};
  };
}
