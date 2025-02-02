{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # host-specific
  environment.systemPackages = with pkgs; [gparted];

  # my nixos modules
  nixosModules = {
    users.usernames = ["nmeusling"];
    steam.enable = true;
  };

  system.stateVersion = "24.05";
}
