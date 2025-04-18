# Import all aliases modules found in the aliases directory
{
  ansiColors,
  lib,
  nixosConfig,
  ...
}:
let
  # Check if the first line matches the required header
  hasValidHeader =
    file:
    let
      content = builtins.readFile file;
      firstLine = builtins.head (builtins.split "\n" content);
    in
    firstLine == "# Home Manager Zsh aliases module. Do not remove this header.";

  # Import alias files, dynamically passing inputs (e.g. `nixosConfig`) when required
  importAliasFiles =
    dir:
    let
      files = builtins.attrNames (builtins.readDir dir);
      nixFiles = builtins.filter (n: builtins.match ".*\\.nix" n != null) files;
      fullPaths = map (f: dir + "/${f}") nixFiles;
      validFiles = builtins.filter hasValidHeader fullPaths;
      contents = map (
        file:
        let
          importedFn = import file; # Returns a function
          args = builtins.functionArgs importedFn; # Get expected arguments
          actualArgs =
            {
              inherit ansiColors;
            }
            // (if args ? "lib" then { inherit lib; } else { })
            // (if args ? "nixosConfig" then { inherit nixosConfig; } else { });
          result = importedFn actualArgs; # Call the function with appropriate args
        in
        if builtins.hasAttr "aliases" result then result.aliases else ""
      ) validFiles;
      merged = builtins.foldl' (a: b: a // b) { } contents;
    in
    merged;
in
{
  allAliases = importAliasFiles ./aliases;
}
