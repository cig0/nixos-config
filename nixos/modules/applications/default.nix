# Don't remove this line! This is a NixOS APPLICATIONS module.

#  _____                                                              _____
# ( ___ )                                                            ( ___ )
#  |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   |
#  |   | ░░░░░░░█▀█░█▀█░█▀█░█░░░▀█▀░█▀▀░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░ |   |
#  |   | ░░░░░░░█▀█░█▀▀░█▀▀░█░░░░█░░█░░░█▀█░░█░░░█░░█░█░█░█░▀▀█░░░░░░ |   |
#  |   | ░░░░░░░▀░▀░▀░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░ |   |
#  |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___|
# (_____)                                                            (_____)
# {
#   imports = builtins.filter (x: x != null) [
#   ];
# }

let
  # Import the reusable dynamic importer module
  dynamicImporter = import ../../lib/dynamic-importer.nix;

  # Get the directory of the current file
  currentDir = builtins.path { path = ./.; };

  # Load APPLICATIONS modules
  modules = dynamicImporter {
    firstLine = "# Don't remove this line! This is a NixOS APPLICATIONS module.";
    dir = currentDir;
  };
in
modules # Just return the modules directly, don't wrap in another imports
