{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  # host-specific
  environment.systemPackages = with pkgs; [gparted];

  # my nixos modules
  nixosModules = {
    users.usernames = ["thamenato"];
    steam.enable = true;
  };

  system.stateVersion = "24.05";
}
