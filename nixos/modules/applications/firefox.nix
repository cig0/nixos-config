# firefox.nix - Firefox Web Browser

{ ... }:

{
  # Use the KDE file picker - https://wiki.archlinux.org/title/firefox#KDE_integration
  programs = {
    firefox = {
      enable = true;
      preferences = { "widget.use-xdg-desktop-portal.file-picker" = "1"; };
    };
  };
}