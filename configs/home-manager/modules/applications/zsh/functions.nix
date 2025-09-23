# Import all function modules found in the functions directory
{
  config,
  libAnsiColors,
  nixosConfig,
  self,
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
    firstLine == "# Home Manager Zsh functions module. Do not remove this header.";

  # Import function files, dynamically passing inputs (e.g. `nixosConfig`) when required
  importFunctionFiles =
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
          actualArgs = {
            inherit
              config
              libAnsiColors
              nixosConfig
              self
              ;
          };
          result = importedFn actualArgs; # Call the function with appropriate args
        in
        if builtins.hasAttr "functions" result then result.functions else ""
      ) validFiles;
      merged = builtins.concatStringsSep "\n" contents;
    in
    merged;
in
{
  allFunctions = importFunctionFiles ./functions;
}
