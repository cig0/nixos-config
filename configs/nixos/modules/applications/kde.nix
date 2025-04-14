{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixos;
in
{
  options.myNixos = {
    programs = {
      kde-pim = {
        enable = lib.mkEnableOption "Whether to enable KDE PIM base packages.";
      };

      kdeconnect.enable = lib.mkEnableOption "Whether to enable kdeconnect.";
    };

    services.desktopManager.plasma6.enable = lib.mkEnableOption "Enable the Plasma 6 (KDE 6) desktop environment.";
  };

  config = lib.mkIf cfg.services.desktopManager.plasma6.enable {
    programs = {
      dconf.enable = true; # https://wiki.nixos.org/wiki/KDE#Installation
      kde-pim = {
        enable = cfg.programs.kde-pim.enable;
        kmail = true;
        kontact = true;
        merkuro = true;
      };
      kdeconnect.enable = cfg.programs.kdeconnect.enable;
    };

    services.desktopManager.plasma6.enable = true;
  };
}
