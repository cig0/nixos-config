# https://wiki.nixos.org/wiki/Fonts
# For a valid font names list check the font assets filenames:  https://github.com/ryanoasis/nerd-fonts/releases
{
  pkgs,
  ...
}:
{
  console = {
    enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true; # Should ensure a clear and crisp text rendering.
    };
    fontDir.enable = true; # Helps Flatpak applications find system fonts.
    packages =
      with pkgs.nerd-fonts;
      [
        _0xproto
        code-new-roman
        hack
        mononoki
        recursive-mono
        ubuntu-sans
      ]
      ++ (with pkgs; [ terminus_font_ttf ]);
  };
}
