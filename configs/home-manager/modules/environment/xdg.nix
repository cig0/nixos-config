{
  pkgs,
  ...
}:
{
  xdg = {
    enable = true;
    portal = {
      enable = true;
      config = {
        common = {
          default = [
            pkgs.xdg-desktop-portal-wlr
          ];
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        # xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
