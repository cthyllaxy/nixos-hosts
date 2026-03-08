{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  # my nixos modules
  nixosModules = {
    users.usernames = ["thamenato"];
    steam.enable = true;
  };

  system.stateVersion = "24.05";
}
