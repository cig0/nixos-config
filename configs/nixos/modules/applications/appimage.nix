{ config, lib, ... }:
let
  cfg = config.myNixos.programs.appimage;
in
{
  options.myNixos.programs.appimage = {
    enable = lib.mkEnableOption "Whether to enable appimage-run wrapper script for executing appimages on NixOS.";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      # "https://wiki.nixos.org/wiki/Appimage"
      appimage = {
        enable = true;
        binfmt = true;
      };

      fuse.userAllowOther = true;
    };
  };
}
