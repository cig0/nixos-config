# NixOS' modules loader
#  _____                                      _____
# ( ___ )                                    ( ___ )
#  |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   |
#  |   | ░░░░░░░█▀▀░█░█░█▀▀░▀█▀░█▀▀░█▄█░░░░░░ |   |
#  |   | ░░░░░░░▀▀█░░█░░▀▀█░░█░░█▀▀░█░█░░░░░░ |   |
#  |   | ░░░░░░░▀▀▀░░▀░░▀▀▀░░▀░░▀▀▀░▀░▀░░░░░░ |   |
#  |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___|
# (_____)                                    (_____)
{
  imports = builtins.filter (x: x != null) [
    ./audio/default.nix
    ./cups.nix
    ./current-system-packages-list.nix
    ./environment/default.nix
    ./maintenance/default.nix
    ./nixos/default.nix
    ./fonts.nix
    ./hardware-acceleration.nix
    ./kernel.nix
    ./keyd.nix
    ./ntp.nix
    ./users.nix
  ];
}
