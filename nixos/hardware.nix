{pkgs, ...}: {
  hardware = {
    # enable opengl
    graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = with pkgs; [
        # amdvlk
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
      ];
    };

    # support SANE scanners
    sane.enable = true;
  };
}
