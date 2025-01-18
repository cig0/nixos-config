# ░░░░░░░█░█░█▀█░█▀▄░█▀▄░█░█░█▀█░█▀▄░█▀▀░░░░░░
# ░░░░░░░█▀█░█▀█░█▀▄░█░█░█▄█░█▀█░█▀▄░█▀▀░░░░░░
# ░░░░░░░▀░▀░▀░▀░▀░▀░▀▀░░▀░▀░▀░▀░▀░▀░▀▀▀░░░░░░
{
  imports = builtins.filter (x: x != null) [
    ./power-management/main.nix
    ./radio/main.nix
    ./nvidia.nix
  ];
}
