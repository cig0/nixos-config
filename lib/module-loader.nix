/*
  Dynamic modules loader.

  This module provides functions to recursively scan directories for Nix modules
  with configurable exclusion paths and module detection patterns.
*/
{
  lib,
  ...
}:
{
  # Function to collect modules from a directory with configurable options
  collectModules = {
    dir,                   # Directory to scan
    excludePaths ? [],     # Paths to exclude
    modulePatterns ? [     # Patterns to identify modules
      "... }:"
      "}:"
      "config,"
      "lib,"
      "inputs,"
      "nixosConfig,"
      "pkgs,"
      "config ="
      "imports ="
      "options ="
    ]
  }:
  let
    # Check if a path contains any of the special paths that should be excluded
    isExcludedPath =
      path:
      let
        strPath = toString path;
      in
      builtins.any (excludePath: lib.strings.hasInfix excludePath strPath) excludePaths;

    # Check if a file is likely a Nix module based on content patterns
    isNixModule =
      file:
      let
        content = builtins.readFile file;
      in
      builtins.any (pattern: lib.strings.hasInfix pattern content) modulePatterns;

    # Recursively collect .nix files from a directory
    collectModulesRec =
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
            if isExcludedPath fullPath then
              # Skip files in excluded paths
              [ ]
            else if isNixModule fullPath then
              [ fullPath ]
            else
              [ ]
          else if type == "directory" then
            # It's a directory, recurse into it
            collectModulesRec fullPath
          else
            [ ]; # Ignore other files

        # Map over all items and collect the results
        itemLists = lib.mapAttrsToList processItem items;

        # Flatten the list of lists
        flattenedList = lib.flatten itemLists;
      in
      flattenedList;
  in
  collectModulesRec dir;
}
