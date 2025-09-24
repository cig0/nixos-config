{
  config,
  lib,
  ...
}: let
  cfg = lib.getAttrFromPath ["myNixos" "services" "displayManager"] config;
  # cfg = {
  #   autoLoginEnable = config.myNixos.services.displayManager.autoLogin.enable;
  #   autoLoginUser = config.myNixos.ervices.displayManager.autoLogin.user;
  #   ly = config.myNixos.ervices.displayManager.ly.enable;
  #   sddm = config.myNixos.ervices.displayManager.sddm.enable;
  # };
in {
  options.myNixos = {
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
