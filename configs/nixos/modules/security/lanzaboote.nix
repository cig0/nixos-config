{
  config,
  lib,
  myArgs,
  ...
}:
let
  cfg = config.myNixos.boot.lanzaboote;
in
{
  options.myNixos.boot.lanzaboote.enable = lib.mkEnableOption "Secure boot for NixOS";

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
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };

    # Additional module packages
    myNixos.myOptions.packages.modulePackages = with myArgs.packages.pkgsUnstable; [
      sbctl
    ];
  };
}
