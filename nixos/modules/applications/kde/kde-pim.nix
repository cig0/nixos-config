# kde.nix - KDE Personal Information Management suite

{ ... }:

{
    programs.kde-pim = {
      enable = false;
      kmail = true;
      kontact = true;
      merkuro = true;
    };
}