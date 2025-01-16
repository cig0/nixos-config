{ config, lib, ... }:

let
  cfg = {
    autoLoginEnable = config.mySystem.services.displayManager.autoLogin.enable;
    autoLoginUser = config.mySystem.services.displayManager.autoLogin.user;
    ly = config.mySystem.services.displayManager.ly.enable;
    sddm = config.mySystem.services.displayManager.sddm.enable;
  };

in {
  options.mySystem = {
    services.displayManager = {
      autoLogin = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Automatic login on boot";
        };
        user = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Username for automatic login on boot. Set to null to disable.";
        };
      };
      ly.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Ly Display Manager";
      };

      sddm.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "SDDM Display Manager (KDE default option)";
      };
    };
  };

  config = {
    services.displayManager = {
      autoLogin= {
        enable = cfg.autoLoginEnable;
        user = cfg.autoLoginUser;
      };
      ly = {
        enable = cfg.ly;
        settings = {
          animation = "doom";
          hide_borders = true;
        };
      };
      sddm = {
        enable = cfg.sddm;
        enableHidpi = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
    };
  };
}