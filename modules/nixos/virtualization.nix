# modules/nixos/virtualization.nix
{...}: {
  flake.nixosModules.virtualization = {...}: {
    virtualisation = {
      docker = {
        enable = true;
        daemon.settings = {
          experimental = true;
          features = {
            containerd-snapshotter = true;
            buildkit = true;
          };
        };
      };
    };
  };
}
