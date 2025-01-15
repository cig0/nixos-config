{ config, inputs, lib, ... }:

let
  cfg = config.mySystem.boot.lanzaboote;

in {
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  options.mySystem.boot.lanzaboote = lib.mkOption {
    type = lib.types.enum [ "true" "false" ];
    default = "false";
    description = "Secure boot for NixOS";
  };

  config = lib.mkIf (cfg == "true") {
    # Refs:
    # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
    # https://wiki.nixos.org/wiki/Secure_Boot

    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}