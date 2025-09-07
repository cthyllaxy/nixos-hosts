{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  environment.systemPackages = with pkgs; [
    system76-firmware
  ];

  # laptop battery optimization
  programs.auto-cpufreq = {
    enable = false;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };

      battery = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };

  services.xserver.videoDrivers = ["amdgpu"];

  # nixos modules
  nixosModules = {
    users.usernames = ["thamenato" "nmeusling"];
    steam.enable = true;
  };

  system.stateVersion = "23.11";
}
