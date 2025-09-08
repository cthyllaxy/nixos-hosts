{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation rec {
  pname = "nh-update";
  version = "0.1.1";

  src = ./.;

  nativeBuildInputs = with pkgs; [makeWrapper];

  # If your script has dependencies, list them here
  buildInputs = with pkgs; [
    bash
    argc
    nh
    unixtools.ping
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp nh-update.sh $out/bin/nh-update
    chmod +x $out/bin/nh-update

    # Wrap the script to ensure dependencies are in PATH
    wrapProgram $out/bin/nh-update \
      --prefix PATH : ${pkgs.lib.makeBinPath buildInputs}
  '';

  meta = with pkgs.lib; {
    description = "My nh wrapper with batteries included";
    platforms = platforms.x86_64;
  };
}
