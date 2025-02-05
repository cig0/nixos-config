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
    ./fwupd.nix
    ./hwaccel.nix
    ./kernel.nix
    ./keyd.nix
    ./ntp.nix
    ./ucode.nix
    ./users.nix
    ./zram.nix
  ];
}
