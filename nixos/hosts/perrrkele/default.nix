# perrrkele's shared modules loader
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
    ./modules/hardware/default.nix # Host-specific hardware configuration additions
    ./modules/system/default.nix # Keyboard mapping. Useful to re-map keys in keyboards with missing keys, e.g. the Insert key
    ./configuration.nix
    ./options.nix
  ];
}
