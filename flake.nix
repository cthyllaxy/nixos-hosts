{
  description = "Cthyllaxy NixOS Hosts";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

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
        inputs.disko.nixosModules.disko
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        inputs.determinate.nixosModules.default
        hmPkgsConfig
        ./nixos
        ./hosts/${hostName}/configuration.nix
      ];
    });
  in {
    checks = {
      pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          check-added-large-files.enable = true;
          check-yaml.enable = true;

          deadnix.enable = true;
          detect-private-keys.enable = true;
          end-of-file-fixer.enable = true;
          alejandra.enable = true;
          trim-trailing-whitespace.enable = true;
        };
      };
    };

    devShell."${system}" = pkgs.mkShell {
      inherit (self.checks.pre-commit-check) shellHook;
      buildInputs = self.checks.pre-commit-check.enabledPackages;

      packages = with pkgs; let
        nh-update = pkgs.callPackage ./packages/nh-update {};
      in [
        # scripts
        nh-update
        # tools
        just
        yq
        nixpkgs-fmt
        sops
        # language server
        yaml-language-server
        nil
      ];
    };

    nixosConfigurations = {
      kassogtha = mkHost {hostName = "kassogtha";};
      zoth-ommog = mkHost {hostName = "zoth-ommog";};
      ythogtha = mkHost {hostName = "ythogtha";};
      cthylla = mkHost {hostName = "cthylla";};
    };
  };
}
