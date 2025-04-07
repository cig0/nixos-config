# https://wiki.nixos.org/wiki/Fonts
# For a valid font names list check the font assets filenames:  https://github.com/ryanoasis/nerd-fonts/releases
{
  pkgs,
  ...
}:
{
  console = {
    enable = true;
    font = "Lat2-Terminus16";
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true; # Should ensure a clear and crisp text rendering.
    };
    fontDir.enable = true; # Helps Flatpak applications find system fonts.
    packages =
      with pkgs;
      [
        ibm-plex
      ]
      ++ [
        (nerdfonts.override {
          fonts = [
            "0xProto"
            "CodeNewRoman"
            "Hack"
            "Mononoki"
            "Recursive"
            "Terminus"
            "UbuntuSans"
          ];
        })
      ];
  };
}
