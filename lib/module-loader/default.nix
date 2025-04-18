/*
  Dynamic module loader:
  Recursively scans directories for Nix modules, with configurable exclusions and detection.

  Do not modify `excludePaths ? [ ]` here; there's a reason it's intentionally defined  outside
  the main `let` block.

  For more details, see README.md.
*/
{
  lib,
  ...
}:
let
  # List of module names to exclude
  excludeModules = [
    "configuration.nix"
    "hardware-configuration.nix"
    "module-loader.nix"
  ];

  # TODO: think about a more robust way to detect if a file is a NixOS module
  modulePatterns = [
    # Patterns to identify modules
    "... }:"
    "}:"
    "config,"
    "lib,"
    "inputs,"
    "nixosConfig,"
    "pkgs,"
    "config = {"
    "home = {"
    "imports = ["
    "options."
  ];
in
{
  # Collect modules from a directory with configurable options
  collectModules =
    {
      dir, # Directory to scan
      excludePaths ? [ ],
      moduleDetection ? modulePatterns,
    }:
    let
      # Ensure excludePaths is empty when passed to this function
      _ =
        if excludePaths != [ ] then
          throw ''
            Error: 'excludePaths' must be empty when passed to 'collectModules'. (Did you read the accompanying documentation?)\n
            Found: ${toString excludePaths}"
          ''
        else
          null;

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
        builtins.any (pattern: lib.strings.hasInfix pattern content) moduleDetection;

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
            if type == "regular" && lib.hasSuffix ".nix" name && !(lib.elem name excludeModules) then
              # It's a .nix file that's not a known NixOS module, e.g. configuration.nix or
              # default.nix, check if it's a module
              if isExcludedPath fullPath then
                # Skip files in excluded paths
                [ ]
              else
                lib.optional (isNixModule fullPath) fullPath
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
