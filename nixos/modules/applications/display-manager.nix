{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["mySystem" "services" "displayManager"] config;
  # cfg = {
  #   autoLoginEnable = config.mySystem.services.displayManager.autoLogin.enable;
  #   autoLoginUser = config.mySystem.services.displayManager.autoLogin.user;
  #   ly = config.mySystem.services.displayManager.ly.enable;
  #   sddm = config.mySystem.services.displayManager.sddm.enable;
  # };
in {
  options.mySystem = {
    services.displayManager = {
      autoLogin = {
        enable = lib.mkEnableOption "Automatically log in as {option}`autoLogin.user`.";
        user = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "User to be used for the automatic login.";
        };
      };
      ly.enable = lib.mkEnableOption "Whether to enable ly as the display manager.";
      sddm.enable = lib.mkEnableOption "Whether to enable sddm as the display manager.";
    };
  };

  config = {
    services.xserver.enable = false; # Disable X11 as we are cool kidz only using the Wayland session.

    services.displayManager = {
      autoLogin = {
        enable = cfg.autoLogin.enable;
        user = cfg.autoLogin.user;
      };
      ly = {
        enable = cfg.ly.enable;
        settings = {
          animation = "doom";
          hide_borders = true;
        };
      };
      sddm = {
        enable = cfg.sddm.enable;
        enableHidpi = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
    };
  };
}
