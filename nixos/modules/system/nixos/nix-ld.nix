{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mySystem.programs.nix-ld;
in {
  options.mySystem.programs.nix-ld.enable = lib.mkEnableOption "Run unpatched dynamic binaries on NixOS.";

  imports = [inputs.nix-ld.nixosModules.nix-ld];

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
# READ ME!
# ========
# https://github.com/nix-community/nix-ld

