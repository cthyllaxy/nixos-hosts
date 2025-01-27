{inputs, ...}: let
  system = "x86_64-linux";

  hmPkgsConfig = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "bak";
    };
  };

  mkHost = {
    hostName,
    user ? "thamenato",
  }: (inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = {
      inherit inputs;
      meta = {
        inherit hostName;
        inherit user;
      };
    };

    modules = [
      inputs.auto-cpufreq.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      inputs.disko.nixosModules.disko
      inputs.sops-nix.nixosModules.sops
      hmPkgsConfig
      ../nixos
      ../hosts/${hostName}/configuration.nix
    ];
  });
in {
  inherit mkHost;
}
