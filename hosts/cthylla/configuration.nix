{
  imports = [
    ./hardware-configuration.nix
  ];

  # my nixos modules
  nixosModules = {
    users.usernames = ["nmeusling"];
    steam.enable = true;
  };

  system.stateVersion = "24.05";
}
