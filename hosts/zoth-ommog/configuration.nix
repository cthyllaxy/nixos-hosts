{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  # host-specific packages
  environment.systemPackages = with pkgs; [
    amdgpu_top
    discord
    dualsensectl
    gparted
    lutris
  ];

  services = {
    # bluetooth config
    blueman.enable = true;
    # extra rules from https://github.com/nowrep/dualsensectl
    udev.extraRules = ''
      # PS5 DualSense controller over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"

      # PS5 DualSense controller over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"

      # PS5 DualSense Edge controller over USB hidraw
      KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0df2", MODE="0660", TAG+="uaccess"

      # PS5 DualSense Edge controller over bluetooth hidraw
      KERNEL=="hidraw*", KERNELS=="*054C:0DF2*", MODE="0660", TAG+="uaccess"
    '';
  };

  services.xserver.videoDrivers = ["amdgpu"];

  # nixos modules
  nixosModules = {
    users.usernames = ["thamenato" "nmeusling"];
    steam = {
      enable = true;
      gamescope = true;
    };
  };

  system.stateVersion = "23.05";
}
