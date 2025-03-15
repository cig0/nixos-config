# NixOS' modules loader
#  _____                                                                      _____
# ( ___ )                                                                    ( ___ )
#  |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   |
#  |   | ░░░░░░░█▀▀░█░█░█▀█░█▀▄░█▀▀░█▀▄░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀░░░░░░░░ |   |
#  |   | ░░░░░░░▀▀█░█▀█░█▀█░█▀▄░█▀▀░█░█░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█░░░░░░░░ |   |
#  |   | ░░░░░░░▀▀▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░░ |   |
#  |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___|
# (_____)                                                                    (_____)
{
  imports = builtins.filter (x: x != null) [
    ./applications/default.nix
    ./common/hardware-options.nix
    ./hardware/default.nix
    ./networking/default.nix
    ./observability/default.nix
    # ./secrets/default.nix # TODO: to be implemented
    ./security/default.nix
    ./system/default.nix
    ./virtualisation/default.nix
  ];
}
