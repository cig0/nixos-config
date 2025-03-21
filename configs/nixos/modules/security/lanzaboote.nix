{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem.boot.lanzaboote;
in
{
  options.mySystem.boot.lanzaboote.enable = lib.mkEnableOption "Secure boot for NixOS";

  config = lib.mkIf cfg.enable {
    /*
      Refs:
      https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
      https://wiki.nixos.org/wiki/Secure_Boot

      Lanzaboote currently replaces the systemd-boot module.

      This setting is usually set to true in the file configuration.nix
      when installing NixOS using the GUI installer, so we force it to
      false here to stick to the separation of concerns principle.

      Also, if at any time we disable Lanzaboote, we don't need to change
      back anything in the configuration.nix file.
    */
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
