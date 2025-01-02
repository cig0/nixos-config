# https://wiki.nixos.org/wiki/Fonts
# For a valid font names list check the font assets filenames:  https://github.com/ryanoasis/nerd-fonts/releases

{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    fontconfig.useEmbeddedBitmaps = true;  # Should ensure a clear and crisp text rendering.
    fontDir.enable = true;  # Helps Flatpak applications find system fonts.
    packages = with pkgs; [
      (nerdfonts.override {fonts = [
        "0xProto"
        "CodeNewRoman"
        "FiraCode"
        "Hack"
        "Mononoki"
        "Recursive"
        "UbuntuSans"
      ];})
    ];
  };
}