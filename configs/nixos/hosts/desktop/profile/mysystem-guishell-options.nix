{
  ...
}:
{
  mySystem = {
    programs.kde-pim.enable = false;
    programs.kdeconnect.enable = true;
    services.displayManager = {
      ly.enable = false;
      sddm.enable = true;
    };
    services.desktopManager.plasma6.enable = true;
    xdg.portal.enable = true;
  };
}
