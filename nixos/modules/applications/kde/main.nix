# ░░░░░░░█░█░█▀▄░█▀▀░░░░░░
# ░░░░░░░█▀▄░█░█░█▀▀░░░░░░
# ░░░░░░░▀░▀░▀▀░░▀▀▀░░░░░░
{
  imports = builtins.filter (x: x != null) [
    ./kde-connect.nix
    ./kde-pim.nix
    ./kde-plasma.nix
  ];
}
