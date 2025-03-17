{
  lib,
  ...
}:
let
  # Get the directory of this file
  dir = ./.;

  /*
    Safety check: Check if a file is likely a NixOS module.
    We will look for common patterns found in NixOS modules.
  */
  isNixOSModule =
    file:
    let
      content = builtins.readFile file;

      # Check for common module patterns using simple string contains
      hasModulePattern =
        lib.strings.hasInfix "... }:" content
        || lib.strings.hasInfix "config," content
        || lib.strings.hasInfix "lib," content
        || lib.strings.hasInfix "inputs," content
        || lib.strings.hasInfix "nixosConfig," content
        || lib.strings.hasInfix "pkgs," content
        || lib.strings.hasInfix "config =" content
        || lib.strings.hasInfix "imports =" content
        || lib.strings.hasInfix "options =" content;
    in
    hasModulePattern;

  # Recursively collect .nix files from a directory
  collectModules =
    path:
    let
      # Read the directory contents
      items = builtins.readDir path;

      # Process each item in the directory
      processItem =
        name: type:
        let
          fullPath = path + "/${name}";
        in
        if type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix" then
          # It's a .nix file that's not default.nix, check if it's a module
          if isNixOSModule fullPath then [ fullPath ] else [ ]
        else if type == "directory" then
          # It's a directory, recurse into it
          collectModules fullPath
        else
          [ ]; # Ignore other files

      # Map over all items and collect the results
      itemLists = lib.mapAttrsToList processItem items;

      # Flatten the list of lists
      flattenedList = lib.flatten itemLists;
    in
    flattenedList;

  # Collect all modules
  modules = collectModules dir;

  # Debug: Print the modules being imported (uncomment if needed)
  # _ = builtins.trace "Importing modules: ${builtins.toJSON modules}" null;
in
{
  imports = builtins.filter (x: x != null) modules;
}
