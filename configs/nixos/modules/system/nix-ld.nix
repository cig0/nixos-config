{
  config,
  _inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixos.programs.nix-ld;
in
{
  imports = [ _inputs.nix-ld.nixosModules.nix-ld ];

  options.myNixos.programs.nix-ld.enable =
    lib.mkEnableOption "Run unpatched dynamic binaries on NixOS.";

  config = lib.mkIf cfg.enable {
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
  };
}
