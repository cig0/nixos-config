{pkgs, ...}: {
  # https://github.com/nix-community/nix-ld
  # (Enabled wih the flake) The module in this repository defines a new module under (programs.nix-ld.dev) instead of (programs.nix-ld) to not collide with the nixpkgs version.
  programs.nix-ld = {
    dev.enable = false;
    enable = true;
    libraries = with pkgs; [
      # From the YT channel "No Boilerplate": https://youtu.be/CwfKIX3rA6E. Go check his cool stuff!
      # Add missing dynamic libraries for unpackaged applications here, NOT in environment.systemPackages.
      curl
      openssl
      zlib
    ];
  };
}
