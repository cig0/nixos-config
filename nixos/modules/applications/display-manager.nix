{ config, lib, ... }:

let
  cfgAutoLoginEnable = config.mySystem.services.displayManager.autoLogin.enable;
  cfgAutoLoginUser = config.mySystem.services.displayManager.autoLogin.user;
  cfgLy = config.mySystem.services.displayManager.ly;
  cfgSddm = config.mySystem.services.displayManager.sddm;

in {
  options.mySystem = {
    services.displayManager = {
      autoLogin = {
        enable = lib.mkOption {
          type = lib.types.enum [ "true" "false" ];
          default = "false";
          description = "Automatic login on boot";
        };
        user = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Username for automatic login on boot. Set to null to disable.";
        };
      };
      ly = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
        description = "Ly Display Manager";
      };

      sddm = lib.mkOption {
        type = lib.types.enum [ "true" "false" ];
        default = "false";
        description = "SDDM Display Manager (KDE default option)";
      };
    };
  };

  config = {
    services.displayManager = {
      autoLogin= {
        enable = cfgAutoLoginEnable == "true";
        user = cfgAutoLoginUser;
      };
      ly = {
        enable = cfgLy == "true";
        settings = {
          animation = "doom";
          hide_borders = true;
        };
      };
      sddm = {
        enable = cfgSddm == "true";
        enableHidpi = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
    };
  };
}