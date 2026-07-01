# modules/nixos/hardware.nix
{...}: {
  flake.nixosModules.hardware = {pkgs, ...}: {
    hardware = {
      bluetooth = {
        enable = true;
        package = pkgs.bluez5-experimental;
        settings = {
          Policy.AutoEnable = "true";
          General.Enable = "Source,Sink,Media,Socket";
        };
      };
      # enable opengl
      graphics = {
        enable = true;
        enable32Bit = true;

        extraPackages = with pkgs; [
          # amdvlk
          vulkan-loader
        ];
      };

      # support SANE scanners
      sane.enable = true;
    };
  };
}
