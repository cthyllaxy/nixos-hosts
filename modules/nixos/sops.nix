# modules/nixos/sops.nix
{...}: {
  flake.nixosModules.sops = {...}: {
    sops = {
      defaultSopsFile = ../../secrets/hosts.yaml;
      age.keyFile = "/sops/age/keys.txt";
    };
  };
}
