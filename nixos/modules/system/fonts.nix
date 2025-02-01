# https://wiki.nixos.org/wiki/Fonts
# For a valid font names list check the font assets filenames:  https://github.com/ryanoasis/nerd-fonts/releases
{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true; # Should ensure a clear and crisp text rendering.
    };
    enableDefaultPackages = true;
    fontDir.enable = true; # Helps Flatpak applications find system fonts.
    packages = with pkgs;
      [
        ibm-plex
      ]
      ++ [
        (nerdfonts.override {
          fonts = [
            "0xProto"
            "CodeNewRoman"
            "FiraCode"
            "Hack"
            "Mononoki"
            "Recursive"
            "UbuntuSans"
          ];
        })
      ];
  };
}
