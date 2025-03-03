# NixOS's
#  _____                                            _____
# ( ___ )                                          ( ___ )
#  |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   |
#  |   | ░░░░░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀░░░░░░░░ |   |
#  |   | ░░░░░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█░░░░░░░░ |   |
#  |   | ░░░░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░ |   |
#  |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___|
# (_____)                                          (_____)
{
  imports = builtins.filter (x: x != null) [
    ./applications/default.nix
    ./hardware/default.nix
    ./networking/default.nix
    ./observability/default.nix
    ./security/default.nix
    ./system/default.nix
    ./virtualisation/default.nix
  ];
}
