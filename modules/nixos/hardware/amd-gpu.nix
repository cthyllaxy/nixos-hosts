# modules/nixos/hardware/amd-gpu.nix
{...}: {
  flake.nixosModules."hardware/amd-gpu" = {...}: {
    services.xserver.videoDrivers = ["amdgpu"];
  };
}
