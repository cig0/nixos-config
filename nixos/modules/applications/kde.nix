{
  config,
  lib,
  ...
}:
let
  cfg = config.mySystem;
in
{
  options.mySystem.programs = {
    kde-pim = {
      enable = lib.mkEnableOption "Whether to enable KDE PIM base packages.";
    };

    kdeconnect.enable = lib.mkEnableOption "Whether to enable kdeconnect.";
  };

  options.mySystem.services.desktopManager.plasma6.enable =
    lib.mkEnableOption "Enable the Plasma 6 (KDE 6) desktop environment.";

  config = lib.mkIf cfg.services.enable {
    programs = {
      dconf.enable = true; # https://wiki.nixos.org/wiki/KDE#Installation
      kde-pim = cfg.programs.kde-pim.enable {
        enable = true;
        kmail = true;
        kontact = true;
        merkuro = true;
      };
      kdeconnect.enable = cfg.programs.kdeconnect.enable;
    };

    services.desktopManager.plasma6.enable = true;
  };
}
