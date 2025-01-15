{ config, lib, ... }:

let
  cfgAutoLoginEnable = config.mySystem.displayManager.autoLogin.enable;
  cfgAutoLoginUser = config.mySystem.displayManager.autoLogin.user;
  cfgLy = config.mySystem.displayManager.ly;
  cfgSddm = config.mySystem.displayManager.sddm;

in {
  options.mySystem = {
    displayManager = {
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