#  _____                                  _____
# ( ___ )                                ( ___ )
#  |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   |
#  |   | ░░░░░░░█▀█░▀█▀░█░█░█▀█░█▀▀░░░░░░ |   |
#  |   | ░░░░░░░█░█░░█░░▄▀▄░█░█░▀▀█░░░░░░ |   |
#  |   | ░░░░░░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░░░░ |   |
#  |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___|
# (_____)                                (_____)
{
  imports = builtins.filter (x: x != null) [
    # ./nix-index-database.nix
    ./nix-ld.nix
  ];
}
# READ ME!
# ========
# The dreadful infinite recursion issue hits again!
# TODO: understand why infinite recursion happens when working with imports.
# { config, ... }:
# {
#   imports = builtins.filter (x: x != null) [
#     (if builtins.hasAttr "nix-index-database" config.programs
#      then ./nix-index-database.nix
#      else null)
#     ./nix-ld.nix
#   ];
# }

