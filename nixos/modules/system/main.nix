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
    ./audio/main.nix
    ./cups.nix
    ./current-system-packages-list.nix
    ./environment/main.nix
    ./maintenance/main.nix
    ./nixos/main.nix
    ./fonts.nix
    ./fwupd.nix
    ./hwaccel.nix
    ./kernel.nix
    ./keyd.nix
    ./ucode.nix
    ./users.nix
    ./zram.nix
  ];
}
