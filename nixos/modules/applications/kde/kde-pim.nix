# kde.nix - KDE Personal Information Management suite

{ ... }:

{
  programs.kde-pim = {
    enable = true;
    kmail = true;
    kontact = true;
    merkuro = true;
  };
}