{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        # "repl-flake"
      ];
      allowed-users = [
        "thamenato"
        "nmeusling"
      ];
      trusted-users = [
        "thamenato"
        "nmeusling"
      ];
      warn-dirty = false;
      substituters = [
        "https://nix-cache.cthyllaxy.xyz"
        "https://nix-community.cachix.org"
        "https://ghostty.cachix.org"
      ];
      trusted-public-keys = [
        "nix-cache.cthyllaxy.xyz:CEJYeiGUveq4GMALY2GHhcIwrr5PwYwdUj6skoHmBH8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      ];
    };
    # optimise.automatic = true;
  };
}
