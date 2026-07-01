# modules/systems.nix
# Basic flake-parts configuration.
#
# Note: unlike `flake.homeModules` (which flake-parts does not know about),
# `flake.nixosModules` and `flake.nixosConfigurations` are built-in flake-parts
# outputs, so no custom `options` declaration is needed here.
{
  config.systems = ["x86_64-linux"];
}
