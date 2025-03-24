{
  config,
  lib,
  ...
}:
let
  cfg = lib.getAttrFromPath [ "mySystem" "programs" "firefox" ] config;
in
{
  options.mySystem.programs.firefox.enable =
    lib.mkEnableOption "Whether to enable the Firefox web browser.";

  config = {
    programs = {
      firefox = {
        enable = cfg.enable;
        preferences = {
          "gfx.x11-egl.force-enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.rdd-ffmpeg.enabled" = true;
          "media.av1.enabled" = false; # https://github.com/TLATER/dotfiles/blob/561931560d2c12e81f139ef8c681e6d99fc6c54e/nixos-modules/nvidia/vaapi.nix#L59
          "widget.dmabuf.force-enabled" = true;
          "widget.use-xdg-desktop-portal.file-picker" = "1"; # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
        };
      };
    };
  };
}
